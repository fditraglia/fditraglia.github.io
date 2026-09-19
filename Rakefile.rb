require 'time'

desc 'create a new draft post'
task :post do
  title = ENV['TITLE']
  slug = "#{Date.today}-#{title.downcase.gsub(/[^\w]+/, '-')}"

  file = File.join(
    File.dirname(__FILE__),
    '_posts',
    slug + '.markdown'
  )

  File.open(file, "w") do |f|
    f << <<-EOS.gsub(/^    /, '')
    ---
    layout: post
    title: #{title}
    published: false
    categories:
    ---

    EOS
  end

  system("#{ENV['EDITOR']} #{file}")
end

# Local builds need Homebrew's Ruby 3.3 and the gems installed by `rake setup`.
# The tasks below set that environment up, so none of it has to be remembered.
JEKYLL_ENV = {
  'PATH' => "/opt/homebrew/opt/ruby@3.3/bin:#{ENV['PATH']}",
  'BUNDLE_PATH' => File.join(Dir.home, '.bundle-github-pages')
}

desc 'one-time setup: install Ruby 3.3 and the GitHub Pages gems'
task :setup do
  sh 'brew install ruby@3.3'
  sh JEKYLL_ENV, 'bundle install'
end

desc 'check _data/papers.yml for mistakes that would break or disfigure the site'
task :check do
  require 'yaml'
  path = File.join(File.dirname(__FILE__), '_data', 'papers.yml')
  begin
    data = YAML.load_file(path)
  rescue Psych::SyntaxError => e
    abort "papers.yml is not valid YAML: #{e.message}"
  end

  problems = []
  ids = Hash.new(0)
  known = %w[id title title_html url doi coauthors et_al journal status year volume issue
             pages article venue_note note links summary abstract abstract_source todo]
  sections = %w[publications working_papers in_progress]
  problems << "top-level sections must be #{sections.join(', ')}" unless data.is_a?(Hash) && data.keys.sort == sections.sort

  sections.each do |section|
    (data[section] || []).each_with_index do |p, i|
      where = "#{section}[#{i}] (#{p['id'] || p['title'] || 'no id'})"
      %w[id title coauthors].each { |k| problems << "#{where}: missing #{k}" if p[k].nil? }
      ids[p['id']] += 1
      (p.keys - known).each { |k| problems << "#{where}: unknown field '#{k}' (typo?)" }
      (p['coauthors'] || []).each do |a|
        problems << "#{where}: each coauthor needs given and family" unless a.is_a?(Hash) && a['given'] && a['family']
      end
      (p['links'] || []).each do |l|
        problems << "#{where}: each link needs label and url" unless l.is_a?(Hash) && l['label'] && l['url']
      end
      if section == 'publications'
        problems << "#{where}: journal is required for a publication" unless p['journal']
        problems << "#{where}: status must be published or forthcoming" unless %w[published forthcoming].include?(p['status'])
        if p['status'] == 'published'
          problems << "#{where}: a published paper needs year and volume" unless p['year'] && p['volume']
          problems << "#{where}: a published paper needs pages or article" unless p['pages'] || p['article']
        end
      end
      problems << "#{where}: pages should use an en dash (–), not a hyphen" if p['pages'].to_s.include?('-')
      problems << "#{where}: abstract has no abstract_source" if p['abstract'] && !p['abstract_source']
      problems << "#{where}: abstract contains LaTeX markup" if p['abstract'].to_s =~ /\\[a-zA-Z]+|~/
    end
  end
  ids.each { |id, n| problems << "id '#{id}' is used #{n} times" if n > 1 }

  if problems.empty?
    n = sections.map { |s| (data[s] || []).size }
    puts "papers.yml is fine: #{n[0]} publications, #{n[1]} working papers, #{n[2]} in progress."
  else
    abort "Problems in papers.yml:\n  - " + problems.join("\n  - ")
  end
end

desc 'check the data file, then build the site into _site'
task :build => :check do
  sh JEKYLL_ENV, 'bundle exec jekyll build'
end

desc 'check the data file, then serve the site at http://localhost:4000 with live rebuild'
task :serve => :check do
  sh JEKYLL_ENV, 'bundle exec jekyll serve'
end

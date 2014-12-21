#Since I can't install the arm package on Glimmer
#(The version of R is too old, and even an archived version of the 
#package has way too many dependencies...)
#I've extracted the relevant code from the package for displaying
#the results of a regression

fround <- function (x, digits) {
  format (round (x, digits), nsmall=digits)
}

pfround <- function (x, digits) {
  print (fround (x, digits), quote=FALSE)
}


display <- function(object, digits=2, detail=FALSE)
{
  out <- NULL
  out$call <- object$call
  summ <- summary (object)
  out$sigma.hat <- summ$sigma
  out$r.squared <- summ$r.squared
  if(detail){
    coef <- summ$coef[,,drop=FALSE]
  }
  else{
    coef <- summ$coef[,1:2,drop=FALSE]
  }
  dimnames(coef)[[2]][1:2] <- c("coef.est","coef.se")
  out$coef <- coef[,"coef.est"]#,drop=FALSE]
  out$se <- coef[,"coef.se"]#,drop=FALSE]
  out$t.value <- summ$coef[,3]
  out$p.value <- summ$coef[,4]
  out$n <- summ$df[1] + summ$df[2]
  out$k <- summ$df[1]
  print (out$call)
  pfround (coef, digits)
  cat("---\n")
  cat (paste ("n = ", out$n, ", k = ", out$k,
              "\nresidual sd = ", fround (out$sigma.hat, digits),
              ", R-Squared = ", fround (out$r.squared, 2), "\n", sep=""))
  return(invisible(out))
}
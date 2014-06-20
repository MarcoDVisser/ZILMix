require(rjags)
require(zil)

## Model mean growth for N trees
N=100
dbh=1:N
mu <- 5+0.2*dbh
realgrowth <- rlnorm(N,mean=log(mu),sd=log(2))
error <- rzil(N,b=2,p=1,mu=0)
observed <- realgrowth+error

## start to define JAGS model file
modelstring=
"
model
{
  ## Hyperparameters and priors
  tau ~ dunif(0,1000)
  sigma <- 1.0/sqrt(tau)
  beta1 ~ dunif(0,20)
  beta0 ~ dunif(0,20)
  ## p and b (must be >0) and 
  ## should be know values from Rick's error data
  ## but they can be fit if need be.
  p <- 1
  b <- 2
 
 ## mean error is assumed to be 0
  meanerror <- 0
  
  ## loop through individuals
  for(i in 1:nind){
    mu[i] <- beta0+beta1*dbh[i]
    Lln[i] <- ifelse(x[i]<0,0,dlnorm(x[i],log(mu[i]),tau))
    Lzil[i] <- ((p*pow(0,abs(x[i])))+(exp(-abs(x[i]-meanerror)/b)/(2*b)))/(1+p)
    L[i] <- (Lln[i] + Lzil[i])/2
    ones[i] ~ dbern(L[i])
  }
}

"

interestlist <- c("sigma","beta0","beta1")

  jagsdata <- list(x=observed, dbh=dbh,
                  nind=length(observed),
                   ones=rep(1,length(observed)))

           model <- jags.model(data=jagsdata,file
                               = textConnection(modelstring)
                              ,n.adapt=5000,n.chains=3)
    update(model,5000)

    codasamp <- coda.samples(model,interestlist,100)





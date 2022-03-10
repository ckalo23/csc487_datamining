library(ggplot2)

# 1
age = c(13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25,
        30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70)

# (a) Use smoothing by bin means to smooth the above data, using a bin depth of 'd'.
#   Illustrate your steps. Comment on the effect of this technique for the given data.
bin_means_deep <- function(x, d){
  age_binMeans = x
  
  for (i in 1:length(age_binMeans)){ # outer for loop to iterate through entire vector
    if(i %% d == 1){ # if index / depth has remainder of 1, you are at first node in bin
      # initialize or reset sum & mean vals for bin
      bin_sum = 0.0 
      bin_mean = 0.0
      
      for (j in i:(i+d-1)){ # for loop for the first node in bin to last node
        bin_sum = bin_sum + age_binMeans[j] # add value at index to bin sum
      }
      bin_mean = bin_sum / d # calculate mean by divided bin sum by its depth
      
      for (k in i:(i+d-1)){ # another for loop for the first node in bin to last node
        age_binMeans[k] = bin_mean # assign bin mean value to the element at each bin index
      }
    }
  }
  return(age_binMeans)
}

age_bin_means = bin_means_deep(age, 3) #call function on 'age' vector w/ bin depth of 3
age_bin_means

# (b) How can you determine outliers in the data?
find_outliers <- function(x){
  qtl <- quantile(x, probs = c(.25,.5,.75))
  iqr <- as.numeric(qtl[3] - qtl[1]) # IQR is q3 - q1, inter-quartile range
  iqr
  
  # lower outlier formula
  low_otlr = as.numeric(qtl[1] - (1.5 * iqr))
  
  # higher outlier formula
  high_otlr = as.numeric(qtl[3] + (1.5 * iqr))
  
  otlrs <- c() # init outliers vector
  a_1q = length(x)%/%4 # index at first quarter of vector
  a_3q = 3*a_1q # index at last quarter of vector 
  
  for (i in 1:a_1q){ # first quarter of vector to iterate/check low outlier 
    if (x[i] < low_otlr){
      otlrs = append(otlrs, x[i])
    }
  }
  for (i in a_3q:length(x)){ # first quarter of vector to iterate/check low outlier 
    if (x[i] > high_otlr){
      otlrs = append(otlrs, x[i])
    }
  }
  return(otlrs)
}

outliers = find_outliers(age)
outliers

# (c) Use min-max normalization to transform the value 35 for age onto the range [0.0, 1.0].
min_max <- function(x, m1, m2) {
  return((x-min(x)) / (max(x)-min(x)) * (m2-m1) + m1) #using min-max formula
}

age_mm = min_max(age, 0, 1)
# finds which index value = 35 (in 'age' vector and
# pulls the first of possible duplicate indexes [1]
i = (which(age==35)[1])
age_mm[i] 
  
# (d) Use z-score normalization to transform the value 35 for age? (you need to compute
#   mean and standard deviation first)
z_score <- function(x) {
  return((x-mean(x)) / sd(x)) #using z-score formula
}

age_z = z_score(age)
# finds which index value = 35 (in 'age' vector and
# pulls the first of possible duplicate indexes [1]
i = (which(age==35)[1])
age_z[i]

# (e) Use normalization by decimal scaling to transform the value 35 for age.
decimal_scale <- function(x){
  dec_arr = x
  max_num = max(x) # get max number in vector 'x'
  
  if (max_num < 10){ # if max number is < 10, divide all values by 10 and return
    for (i in 1:length(x)){
      dec_arr[i] = x[i] / 10
    }
    return(dec_arr)
  }
  
  # if max num is >= 10, create curr_num(initialized w/ max), break & count variables
  curr_num = max_num
  brk = 0
  cnt = 0
  
  while(brk==0){ # while break remains unchanged at 0
    curr_num = curr_num / 10 # current num is / by 10 and count is + by 1
    cnt = cnt + 1
    if (curr_num < 1){ # if/when the current num is less than 1, than this step is done
      brk = 1
    }
  }
  
  for (i in 1:length(x)){ # finally a for loop to add decimal-normalized values to the vector
    dec_arr[i] = x[i] / (10^cnt) # using the decimal scaling formula, 'cnt' exponent shall bring all values under 1
  }
  return(dec_arr)
}

age_ds = decimal_scale(age)
age_ds
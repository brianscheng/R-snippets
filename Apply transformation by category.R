#code for applying transformation by category

#create reproducible data first



for(i in 1:length(error_type)){
  type = error_type[i]
  entries = which(pairs$thermal_limit_error_type == type)
  
  #Transformation of standard errors and 95% confidence intervals were done following the guidelines of Cochrane Handbook for Systematic Reviews of Interventions
  if(type == "std_err"){
    pairs$thermal_limit_sd1[entries] = pairs$thermal_limit_error_1[entries] * sqrt(pairs$n1[entries])
    pairs$thermal_limit_sd2[entries] = pairs$thermal_limit_error_2[entries] * sqrt(pairs$n2[entries])
    
  }
  
  if(type == "CI"){
    pairs$thermal_limit_sd1[entries] = ((pairs$thermal_limit_error_1[entries] * 2) / 3.92) * sqrt(pairs$n1[entries])
    pairs$thermal_limit_sd2[entries] = ((pairs$thermal_limit_error_2[entries] * 2) / 3.92) * sqrt(pairs$n2[entries])
    
  }
  
  if(type == "std_dev"){
    pairs$thermal_limit_sd1[entries] = pairs$thermal_limit_error_1[entries]
    pairs$thermal_limit_sd2[entries] = pairs$thermal_limit_error_2[entries]
    
  }
  
}
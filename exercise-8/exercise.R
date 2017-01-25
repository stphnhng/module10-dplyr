#Use "dplyr" 
#Install.packages("dplyr")

library('dplyr')

#Load in SwissData from data set from data folder and view it to understand what is in it. 

swiss.table <- read.csv("data/SwissData.csv", stringsAsFactors = FALSE)

#Add a column (using dpylr) that is the absolute difference between Education and Examination and call it 
# Educated.Score

swiss.table <- mutate(swiss.table, Educated.Score = abs(Education - Examination))

#Which area(s) had the largest difference 

max.rows <- filter(swiss.table, Educated.Score == max(Educated.Score))
max.regions.difference <- select(max.rows, Region)
print(max.regions.difference)

#Find which region has the highest percent of men in agriculture and retunr only the 
#percent and region name.  Use pipe operators to accomplish this. 

highest.min.agriculture <- filter(swiss.table, Agriculture == max(Agriculture)) %>% select(Region,Agriculture)

#Find the average of all infant.mortality rates and create a column (Mortality.Difference)
# showing the difference between a regions mortality rate and the mean. Arrange the dataframe in 
# Descending order based on this new column. Use pipe operators.

swiss.table <- mutate(swiss.table, Mortality.Difference = Infant.Mortality - mean(Infant.Mortality) ) %>% arrange(-Mortality.Difference)

# Create a new data frame that only is that of regions that have a Infant mortality rate less than the 
# mean.  Have this data frame only have the regions name, education and mortality rate. 

less.than.mean <- filter(swiss.table, Infant.Mortality < mean(Infant.Mortality)) %>% select(Region,Education,Infant.Mortality)

#Filter one of the columns based on a question that you may have (which regions have a higher
#education rate, etc.) and write that to a csv file

filtered.column <- filter(swiss.table, Education == min(Education) )
write.csv(filtered.column, "data/filtered_column.csv")  

# Create a function that can take in two different region names and compare them based on a statistic 
# Of your choice (education, Examination, ect.)  print out a statment describing which one is greater 
# and return a data frame that holds the selected region and the compared variable.  If your feeling adventurous
# also have your function write to a csv file.

compareRegionEducation <- function(region.1, region.2){
  region.1.row <- filter(swiss.table, Region == region.1)
  region.2.row <- filter(swiss.table, Region == region.2)
  final.table <- rbind(region.1.row,region.2.row)  
  region.difference <- region.1.row$Education - region.2.row$Education
  if(region.difference < 0){
    paste(region.2,"has a higher education than",region.1) %>% print()
  }else if(region.difference > 0){
    paste(region.1,"has a higher education than",region.2) %>% print()
  }else{
    paste(region.1,"has the same education as",region.2) %>% print()
  }
  
  return(final.table)
}

compareRegionEducation("Glane","Moudon")






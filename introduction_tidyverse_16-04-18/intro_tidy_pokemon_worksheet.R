# Install the package "tidyverse" and "ggplot2". 
# Installed packages are available to all your R projects. 
# You only need to install a package once and it will be in your library. 
# However, you need to load packages you want to work with from your library for every R project.



# Load the packages "tidyverse" and "ggplot2" from your library



# Read the .csv file with the pokemon dataset.
# Here you have two options: 
# - you can use the button "import dataset" in your environment
# OR
# - directly write a line of code that assigns your datafile to a variable using the readr package of the tidyverse.
# try out both!




# Carefully looking through the dataset. What is the format? Is this tidy data? Discuss!



# How about the variable names?
# They shouldn't be upper case or contain spaces. We want to change that. 
# Run the code chunk below and compare the new tibble to the previous one by running "pokemon" again in the console or by double clicking on the item in your data environment. 
# It will open a new tab containing a spreadsheet-like version of your data. 
# Try to understand what each line of code did to the original dataset.
# - What happens if you switch the two bits of code and run "names(pokemon) <- tolower(names(pokemon))" first? Can you explain what happened?
# - What happens when you switch the code lines back? How can you fix the problem? 

pokemon <-
  pokemon %>% rename(
    no = `#`,
    type1 = `Type 1`,
    type2 = `Type 2`,
    spatk = `Sp. Atk`,
    spdef = `Sp. Def`
  )

names(pokemon) <- tolower(names(pokemon))

# Below you can see how we can turn a variable into a factor.

pokemon$generation <- factor(pokemon$generation, levels = c(1,2,3,4,5,6))

#Now it's your turn! 
# This excersise is a recap of the introduction to R session and an easy practice to get a feeling for the code again before we start with the new content
# - Find more variables, that should be factors and transform them. Also try out what happens when you don't specify the factor levels.

# The str function allows you to look at the structure of your variables. You might be familiar with the variable viewer in SPSS, which is similar. 
# - Look at the structure and the differences between integer variables and factor variables. 




# Tidy data comes in a long format (remember: "each observation is a row"). 
# The opposite is a wide format where each row is a case, which might be what you know from SPSS. 
# Our data doesn't have a very nice long format. In the next step we will reshape our data into a better long format. 
# - First, take a look at our data set: Which variables should be gathered to make the data less wide and give us one observation/row? 
# - Take a piece of paper and draw how the final long data set should look like. 
# Which variables will we have and which values do they take? Discuss this with your neighbour or as a group.




# We want to gather the pokemon type. This is like a repeated measurment variable (each pokemon can have two types). 
# We want one new variable, that tells us the level of measurment (primary or secondary type) and then one variable that gives us the result, here the type (fire, water, bug, dragon etc.).
# To do that we use the gather function. We tell it that we want the new variables "type_priority" which will contain the current variables names (type1 and type2) and the new variable "type" which will contain the value that our current variables take (fire, water, bug, dragon etc.). 
# We need to specify which variables should be gathered. Here we say we want everything between and including type1 and type2, which is indicated by the ":" 

pokemon_long <- gather(pokemon, "type_priority", "type", type1:type2)

print(pokemon)
print(pokemon_long)

# Compare the datasets "pokemon" and "pokemon_long" by looking at the tibbles we printed.


# Below you can see the operation we did before written with the pipe. 
# - Take a look at how the code from above looks like, when we use the pipe. 
# - You understand the pipe operator when you can explain what the two print functions do and why we get again both datasets (pokemon and pokemon_long) although the print commands are empty. 

pokemon_long <- #this will be where we store the final result
  pokemon %>% #the pokemon dataset is the ingedients we use
  print() %>% #we apply this procedure
  gather("type_priority", "type", type1:type2) %>% #we take the result from the previous procedure and apply this
  print() #again we take the result from the previous procedure and print it


# No it's your turn: 
# - Try to gather all the stats for the pokemon into two variables: the type of stats (attack, defense...) and the value. 
# Try to use the pipe operator!
# - If this is easy for you try to combine the previous code chunk and this one and make one single pipeline 




# - Look at the code chunk and try to understand the single transformations we pipe our data through. 
# - It will help you to understand what each line of code does when you look at how the result changes when you disable that step. 
# You can do that by turning the line into a comment. A comment is text within your code, but it is ignored when your code is executed. 
# You can turn text into comments by putting a # in front of it. 

mighty_types <- 
  pokemon_long %>%
  filter(stats_type =="total") %>%
  group_by(type) %>%
  summarise(mean(stats_value)) %>%
  print()

# - Can you produce a new dataset, that compares the average values for all stats except "total" for legendary and non-legendary pokemon? 
# The code chunk below can do the trick. 
# Try to fill in the blanks and make it work 

legendary_types <-
  pokemon_long _____ 
________ (stats_type _____ "total") %>% 
  group_by( _________ , stats_type) %>%
  summarise(mean( ________)) %>%
  print( _____)

# Here I plotted six selected types of pokemon and their total stats in a violin plot using the tidyverse package ggplot2. 
# We will have an extra session on ggplot2, but note that it works perfectly together with the pipe.

pokemon_long %>%
  group_by(type, stats_type) %>%
  select(stats_value) %>%
  filter(stats_type =="total") %>%
  filter(type == c("Bug","Water","Fire","Dragon","Normal", "Fairy")) %>%
  ggplot(aes(type, stats_value)) +
  geom_violin(draw_quantiles = 0.5) +
  theme_classic() 


# With only these few simple commands, we can already do most of our descriptive statistics. 

# - We now want to do a violin plot, that compares the different statistics between legendary and non-legendary pokemon. 
# Below you can see the code-chunk, that produces the plot. Try to fill in the blanks and make it work! 


______________ %>%
  group_by( ____________, stats_type) %>%
  _________(stats_value) %>%
  filter(stats_type != "total") ______
ggplot(aes(stats_type, ___________, fill=legendary)) +
  geom_violin(draw_quantiles = 0.5) +
  theme_classic()


# This "introduction to the tidyverse" was created by Theresa Elise Wege in Feb 18 using the "pokemon with stats" dataset, shared by Alberto Barradas on kaggle.com https://www.kaggle.com/abcsds/pokemon.
# Parts of this workshop are insired by Chris Dong's kernel "Learning R's dplyr, ggplot2, EDA with Pokemon!!" on kaggle.com
# https://www.kaggle.com/cadong/learning-r-s-dplyr-ggplot2-eda-with-pokemon

# This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.


# tidydata ----------------------------------------------------------------
  library(tidyverse)

# pipeline (ctrl + shift + m) ---------------------------------------------

  # Vector de ejemplo
    x <- c(1,2,3,4)

  # sin %>%
  
    # intralineado
      y <- round(mean(sqrt(log(x))))
      
    # interlineado
      z1 <- log(x)
      z2 <- sqrt(z1)
      z3 <- mean(z2)
      y <- round(z3)
    
  # con %>%
    
    # intralineado
      y <- x %>% log %>% sqrt %>% mean %>% round
    
    # interlineado
      y <- x %>% 
        log %>% 
        sqrt %>% 
        mean %>% 
        round

# summarize ---------------------------------------------------------------

  # de 1 variable via summarize
    
    # sin %>% 
      Summary.Petal.Length <- summarize(iris, Mean.Petal.Length = mean(Petal.Length), SD = sd(Petal.Length), N = n())
      
    # con %>% 
      Summary.Petal.Length <- iris %>% 
        summarize(Petal.Length.Mean = mean(Petal.Length), Petal.Length.SD = sd(Petal.Length), Petal.Length.N = n())
      
  # de >=2 variables via summarize_all
      
    # con %>% 
      Summary <- iris %>% 
        group_by(Species) %>% 
        summarize_all(.funs = list(Mean = mean, SD = sd))
      View(Summary)

# group_by ----------------------------------------------------------------

# sin %>% 
  Summary.Petal.Length <- group_by(iris, Species)
  head(Summary.Petal.Length)
  
# con %>% 
  Summary.Petal.Length <- iris %>% group_by(Species)
  head(Summary.Petal.Length)

# group_by & summarize
  
  # sin %>% 
    Summary.Petal.Length <- group_by(iris, Species)
    Summary.Petal.Length <- summarize(Summary.Petal.Length, Mean.Petal.Length = mean(Petal.Length), SD.Petal.Length = sd(Petal.Length))
  # con %>% 
    Summary.Petal.Length <- iris %>% 
      group_by(Species) %>% 
      summarize(Mean.Petal.Length = mean(Petal.Length))

  # Exporting csv file
    write_csv(Summary.Petal.Length, "Summary.Petal.Length.csv")

  # Agrupando por más de una variable    
    View(mtcars) # Base de datos precargada
    Summary.mpg <- group_by(mtcars, am, cyl) # Agrupando base de datos
    Summary.mpg <- summarize(Summary.mpg, Mean.mpg = mean(mpg), SD.mpg = sd(mpg))

# filter ------------------------------------------------------------------
      
  # Opciones de filtrado
    # >,>=,<,<=,==,!=,is.na,!is.na,|,&,%in%
    
  # Base de datos de ejemplo
    head(iris)
    nrow(iris)
    
  # con 1 filtro
  
    # Ejemplo
      df <- iris %>% 
        filter(Species != "versicolor")
    
      nrow(df)
      
    # Ejemplo
      df <- iris %>% 
        filter(Sepal.Length >= 4.5)
      nrow(df)
    
    # con >= 2 filtros
      
      df <- iris %>% 
        filter(Sepal.Length >= 4.5, Sepal.Width != 3)
      nrow(df)
      
      df <- iris %>% 
        filter(Sepal.Length >= 4.5 & Sepal.Width != 3)
      nrow(df)
      
      df <- iris %>% 
        filter(Sepal.Length >= 4.5 | Sepal.Width != 3)
      nrow(df)
      
# select ------------------------------------------------------------------
  
  # 1 columna
    df <- iris %>% select(Petal.Length)
      
    View(df)
    
    df <- iris %>% select(-Petal.Length)
    
    View(df)
    
  # 2 columnas
    df <- iris %>% select(Petal.Length, Species)
    
    View(df)
    
    df <- iris %>% select(starts_with("Petal"))
    
    View(df)
    
    df <- iris %>% select(-starts_with("Petal"))
    
    View(df)
    
    df <- iris %>% select(ends_with("Length"))

    View(df)
    
    df <- iris %>% select(contains("Petal"))
    
    View(df)
    
# mutate: create new variables --------------------------------------------

head(iris)

# sin %>% 
  DF <-  mutate(iris, Ratio.Sepal = Sepal.Length/Sepal.Width)
  head(DF)
  
# con %>% 
  DF <- iris %>% 
    mutate(Ratio.Sepal = Sepal.Length/Sepal.Width)
  head(DF)
    
# Ejercicio
    
  # sin %>%
    
    # Interlínea
      base_datos_1 <- mutate(iris, Petal.Sepal.Ratio = Petal.Length/Sepal.Length)
      base_datos_2 <- group_by(base_datos_1, Species)
      Summary.BySpecies <- summarize(base_datos_2, MEAN = mean(Petal.Sepal.Ratio))
      
      View(Summary.BySpecies)
      
    # Intralínea
      Summary.BySpecies <- summarize(group_by(mutate(iris, Petal.Sepal.Ratio = Petal.Length/Sepal.Length), Species), MEAN = mean(Petal.Sepal.Ratio))
      
      View(Summary.BySpecies)
      
  # con %>% 
    Summary.BySpecies <- iris %>% 
      mutate(Petal.Sepal.Ratio = Petal.Length/Sepal.Length) %>% 
      group_by(Species) %>% 
      summarize(MEAN = mean(Petal.Sepal.Ratio))
    
    View(Summary.BySpecies)
      


    
    
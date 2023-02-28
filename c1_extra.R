# Fuente: YouTube
# Video:  Clase 1 Intro R: Resolución problema
# Url:    https://www.youtube.com/watch?v=jke65mK6A54&t=785s


# pkgs --------------------------------------------------------------------
library(tidyverse)

# Base de datos de ejemplo ------------------------------------------------

  # Cargando base de datos
    dataset <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto19/CasosActivosPorComuna_std.csv")
  
  # View dataset
    View(dataset) 
    #1 Observamos valor "Total" en variable "Comuna"
    #2 Nombres incorrectos de variables
    # Region = Departamento
    # Comuna = Provincia
    
    dataset <- dataset %>% 
      #1
      dplyr::filter(Comuna != "Total") %>%
      #2
      rename(Casos_activos = "Casos activos", Codigo_Region = "Codigo region", Codigo_Comuna = "Codigo comuna")
    
  # Ordenando base de datos
    dataset <- dataset %>% arrange(Codigo_Region, Codigo_Comuna, Fecha)
  
# Pregunta 1 --------------------------------------------------------------
# ¿Qué proporción de comunas han tenido en algún momento más de 50 casos por cada 100.000 habitantes?
    
# Hallando cantidad de comunas sobre 50
  n_Comunas_sobre_50 <- dataset %>%
    # Creando "Casos por cien mil habitantes"
      mutate(Casos_por_100.000 = Casos_activos/Poblacion * 100000) %>% 
    # Filtrando: casos mayores a 50000
      filter(Casos_por_100.000 > 50) %>% 
    # Jalando comunas
      pull(Comuna) %>% # Equivalente a "$" para extraer una columna
    # Unicos casos
      unique() %>% 
    # Longitud
      length() %>% 
    # Mostrar
      print()

# Hallando el total de comunas
  n_Comunas <- dataset %>% 
    pull(Comuna) %>% 
    unique() %>% 
    length() %>% 
    print()

# Hallando la proporción
  proporcion <- (n_Comunas_sobre_50 / n_Comunas) %>% print()
  

# Pregunta 2 --------------------------------------------------------------

#'Genere un dataframe donde aparezca para cada comuna que haya tenido sobre 50 casos
#'por cada 100.000 habitantes la cantidad de días bajo esas condiciones


# Pregunta 3 --------------------------------------------------------------

#'Genere una tabla de las comunas que hayan tenido sobre 50 casos por cada 100.000
#'habitantes y de esas cree una variable que sea la prevalencia máxima de dicha columna
  
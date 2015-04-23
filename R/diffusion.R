# learn more about package authoring with RStudio at: http://r-pkgs.had.co.nz/ Some useful keyboard
# shortcuts for package authoring:
# generate R documentation using roxygen2: 'Cmd + Shift + D' (or running devtools::document())
# Build and Reload Package: 'Cmd + Shift + B'
# Check Package: 'Cmd + Shift + E'
# Test Package: 'Cmd + Shift + T'


####################
# network diffusion
####################
require(igraph)


#' Get the infected nodes
#'
#' @param g A network object generated using igraph.
#' @param transmission_rate A number.
#' @param seed_num The number of seeds.
#' @param random_seed A number for the function set.seed().
#' @return a list of infected nodes (over time).
#' @examples
#' get_infected(barabasi.game(100), 0.4, 1, 2004)
#' get_infected(erdos.renyi.game(100, 0.1), 0.4, 1, 2004)

get_infected = function(g, transmission_rate, seed_num, random_seed){
  toss = function(freq) {
    tossing = NULL
    coins = c(1, 0)
    probabilities = c(transmission_rate, 1-transmission_rate )
    for (i in 1:freq ) tossing[i] = sample(coins, 1, rep=TRUE, prob=probabilities)
    tossing = sum(tossing)
    return (tossing)
  }

  update_diffusers = function(diffusers){
    nearest_neighbors = data.frame(table(unlist(neighborhood(g, 1, diffusers))))
    nearest_neighbors = subset(nearest_neighbors, !(nearest_neighbors[,1]%in%diffusers))
    keep = unlist(lapply(nearest_neighbors[,2],toss))
    new_infected = as.numeric(as.character(nearest_neighbors[,1][keep >= 1]))
    diffusers = unique(c(diffusers, new_infected))
    return(diffusers)
  }

  set.seed(random_seed); diffusers = sample(V(g),seed_num)
  # initialize the infected
  infected =list()
  infected[[1]]= diffusers
  # set the color
  E(g)$color = "grey"
  V(g)$color = "white"
  V(g)$color[V(g)%in%diffusers] = "red"
  # get infected nodes
  total_time = 1
  while(length(infected[[total_time]]) < vcount(g)){
    infected[[total_time+1]] = sort(update_diffusers(infected[[total_time]]))
    total_time = total_time + 1
    }
  # return the infected nodes list
  return(infected)
}


#' plot the time series of network diffusion
#'
#' @param infected A list of infected nodes (over time)
#' @return plots of two time series.
#' @examples
#' plot_time_series(infected)
#' plot_time_series(infected[1:5])

plot_time_series = function(infected){
  num_cum = unlist(lapply(1:length(infected),
                          function(x) length(infected[[x]]) ))
  p_cum = num_cum/node_number
  p = diff(c(0, p_cum))
  time = 1:length(infected)
  plot(p_cum~time, type = "b",
       ylab = "CDF", xlab = "Time",
       xlim = c(0,length(infected)), ylim =c(0,1))
  plot(p~time, type = "h", frame.plot = FALSE,
       ylab = "PDF", xlab = "Time",
       xlim = c(0,length(infected)), ylim =c(0,1))
}


#' plot the diffusion network diffusion (over time)
#'
#' @param infected A list of infected nodes (over time)
#' @return several plots of diffusion networks.
#' @examples
#' plot_gif(infected)
#' plot_gif(infected[1])

plot_gif = function(infected){
  m = 1
  while(m <= length(infected)){
    V(g)$color = "white"
    V(g)$color[V(g)%in%infected[[m]]] = "red"
    plot(g, layout =layout.old, edge.arrow.size=0.2)
    title(paste( "Time", m))
    m = m + 1}
}

# run demos


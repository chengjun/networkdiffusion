# generate a social graph
require(igraph)
require(animation)

node_number = 100
g = barabasi.game(node_number)
# set up the layout
set.seed(2014); layout.old = layout.fruchterman.reingold(g, niter = 1000)
# get the infected
infected = get_infected(g, 0.4, 1, 2004)
plot_gif(infected[[2]])
plot_time_series(infected)

saveGIF({
  ani.options("convert")
  plot_gif(infected)
  }, interval = 0.3, movie.name = "ba.gif", ani.width = 600, ani.height = 600)

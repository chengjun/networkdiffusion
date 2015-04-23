# generate a social graph
require(networkdiffusion)
require(igraph)
require(animation)

# generate a BA network
g = barabasi.game(100)
infected = get_infected(g, 0.4, 1, 2004)
plot_gif(infected[[2]], g)
plot_time_series(infected)

saveGIF({
  ani.options("convert")
  plot_gif(infected, g)
  }, interval = 0.3, movie.name = "ba.gif", ani.width = 600, ani.height = 600)

# generate a small-world network
g = watts.strogatz.game(1,100,3,0.2)
infected = get_infected(g, 0.4, 1, 2004)
plot_gif(infected[[2]], g)
plot_time_series(infected)

saveGIF({
  ani.options("convert")
  plot_gif(infected, g)
}, interval = 0.3, movie.name = "ws.gif", ani.width = 600, ani.height = 600)

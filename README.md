# networkdiffusion
### An R package to simulate and visualize the network diffusion

# Introduction
Network diffusion research focuses on how network structure exerts its impact on the diffusion process. The networkdiffusion package would help you simulate amd visualize the most simple network diffusion with R. The algorithm is quite simple:

- Generate a network g: g(V, E).
- Randomly select one or n nodes as seeds.
- Each infected node influences its neighbors with probability p (transmission rate, β).

# Install

    install.packages("devtools")
    devtools::install_github("chengjun/networkdiffusion")

# Use

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
    
![](./ba.gif)


    # generate a small-world network
    g = watts.strogatz.game(1,100,3,0.2)
    infected = get_infected(g, 0.4, 1, 2004)
    plot_gif(infected[[2]], g)
    plot_time_series(infected)
    
    saveGIF({
      ani.options("convert")
      plot_gif(infected, g)
      }, interval = 0.3, movie.name = "ws.gif", ani.width = 600, ani.height = 600)
    
![](./ws.gif)

    # generate a ring network
    g = connect.neighborhood(graph.ring(30), 2); plot(g)
    infected = get_infected(g, 0.4, 1, 2004)
    plot_gif(infected[[2]], g)
    plot_time_series(infected)
    
    saveGIF({
      ani.options("convert")
      plot_gif(infected, g)
      }, interval = 0.3, movie.name = "ring.gif", ani.width = 600, ani.height = 600)
    
![](./ring.gif)


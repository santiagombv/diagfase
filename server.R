library(shiny)

shinyServer(function(input, output){
  
    output$distPlot <- renderPlot({ 
      
      triang.simul <- function(dt = 0.1, itf = 50, pA, pB, pC){
        ## simulador de la grilla
        X <- seq(0.01, 0.99, length.out = 10)
        D <- expand.grid(X, X)
        names(D)<-c("vA", "vB")
        D$vD <- 1-(D$vA + D$vB)
        D <- D[D$vD>0, ]
        ### iterador
        RR <- list(nrow(D))  
        for(j in 1:nrow(D)){
          eA <- NULL;   eA[1] <- D[j, 1]
          eB <- NULL;   eB[1] <- D[j, 2]
          eC <- NULL;   eC[1] <- D[j, 3]
          time <- NULL
          time[1] <- dt
          for(i in 2:itf){
            time[i] <- dt*i
            fA <- eA[i-1]*pA[1] + eB[i-1]*pA[2] + eC[i-1]*pA[3]
            fB <- eA[i-1]*pB[1] + eB[i-1]*pB[2] + eC[i-1]*pB[3]
            fC <- eA[i-1]*pC[1] + eB[i-1]*pC[2] + eC[i-1]*pC[3]
            meanf <- fA*eA[i-1] + fB*eB[i-1] + fC*eC[i-1]
            eA[i] <- eA[i-1] + eA[i-1]*(1-eA[i-1])*(fA-meanf)*dt
            eB[i] <- eB[i-1] + eB[i-1]*(1-eB[i-1])*(fB-meanf)*dt
            eC[i] <- eC[i-1] + eC[i-1]*(1-eC[i-1])*(fC-meanf)*dt
            RR[[j]] <- data.frame(time, eA, eB, eC)
          }}
        g1 <- ggtern()
        for(i in 1:length(RR)){
          g1 <- g1 + geom_point(data=RR[[i]], aes(x=eA, y=eB, z=eC, color = time))
        }
        g1 <- g1 + scale_color_gradient(low = "darkblue", high = "cyan")
        return(g1)
      }
      
      triang.simul (itf = as.numeric(input$itf), dt = 0.1,
                      pA = c(input$AA, input$AB, input$AC), 
                      pB = c(input$BA, input$BB, input$BC),
                      pC = c(input$CA, input$CB, input$CC))
 
      })
  })


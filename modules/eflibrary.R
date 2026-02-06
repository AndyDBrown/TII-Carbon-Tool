
eflibrary_ui <- function(id,tabName){
  ns <- NS(id)
  
  tabItem(
    tabName = tabName,
    box(width = 12,
        
        fluidRow(
          column(width = 8,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), eflibrary_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T))),
                 h5(tagList(HTML("<br> </br> &nbsp;"), HTML("&nbsp;"), "View CO2 emission factors and associated information for various materials and activities"))
          ),
          column(width = 4, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;")))
          )
        ),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "material_road",
               
               tabPanel(title = "Material (Road)", value = "material_road",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("material_roadDT"))
                                 )
                        )
               ),
               
               tabPanel(title = "Material (Rail)", value = "material_rail",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("material_railDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Activity (Road)", value = "activity_road",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("activity_roadDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Activity (Rail)", value = "activity_rail",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("activity_railDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Construction Activities", value = "const_activities",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("const_activitiesDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Fuel", value = "fuel",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("fuelDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Water", value = "water",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("waterDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Vehicle", value = "vehicle",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("vehicleDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Waste", value = "waste",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("wasteDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Carbon", value = "carbon",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("carbonDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Size", value = "size",
                        #hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("sizeDT"))
                          )
                        )
               )
        )
    )
  )
}

eflibrary_server <- function(id,thetitle, efs_react){
  
  moduleServer(id,
               function(input, output, session){
                 
                 output$some_title <- renderText({thetitle})
                 

                 output$material_roadDT <- DT::renderDataTable({
                   
                   x <- efs_react$data$Material_Road %>%
                     dplyr::select(-`Maintenance %`, -`Project Design Life`) %>%
                     dplyr::mutate(`% replaced in 1 maintenance cycle` = `% replaced in 1 maintenance cycle` * 100.0) %>%  # convert to percentage
                     dplyr::distinct()
                   
                   names(x)[11] <- "Regularity of maintenance cycle (years)"
                   
                   DT::datatable(x,
                                 options = list(autoWidth=T, searching=T, pageLength=5, lengthMenu = c(5,10,20,50), scrollX = TRUE),
                                 filter = c("top"), class = 'hover', rownames = F, escape = F)
                 })
                 
                 output$material_railDT <- DT::renderDataTable({
                   #
                   x <- efs_react$data$Material_Rail %>%
                     dplyr::select(-`Maintenance %`, -`Project Design Life`) %>%
                     dplyr::mutate(`% replaced in 1 maintenance cycle` = `% replaced in 1 maintenance cycle` * 100.0) %>% # convert to percentage
                     dplyr::distinct()
                   
                   names(x)[11] <- "Regularity of maintenance cycle (years)"
                   
                   DT::datatable(x,
                                 options = list(autoWidth=T, searching=T, pageLength=5, lengthMenu = c(5,10,20,50), scrollX = TRUE),
                                 filter = c("top"), class = 'hover', rownames = F, escape = F)
                 })
                 
                 output$activity_roadDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Activity_Road,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$activity_railDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Activity_Rail,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$const_activitiesDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Construction_Activities,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$fuelDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Fuel,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$waterDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Water,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$vehicleDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Vehicle,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$wasteDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Waste,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$carbonDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Carbon,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
                 output$sizeDT <- DT::renderDataTable({
                   DT::datatable(efs_react$data$Size,
                                 options = list(autoWidth=TRUE), filter = c("top"), # options = list(scrollX = TRUE)
                                 class = 'hover', rownames = FALSE, escape = FALSE)
                 })
                 
               }, session = getDefaultReactiveDomain()
  )
}

# adapted from  https://stackoverflow.com/questions/64122281/multiple-tabitems-in-one-shiny-module

### APP ###

##### LIBRARIES #####
library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)
library(shinyWidgets)
library(shinyalert)
library(dashboardthemes)
#library(openxlsx)
library(rio)
library(data.table)
library(dplyr)
library(rhandsontable)
library(DT)
library(plotly)
library(ggplot2)
library(waiter)
library(tcltk)
library(zip)
library(httr)
library(writexl)
library(tableHTML)
library(reactable)
#---------------------------

source(file = "global/global.R") # global variables/functions source file


### sources for MODULES and SUBMODULES ###
source(file = "modules/intro.R")
source(file = "modules/proj_details.R")
source(file = "modules/scoping.R")
source(file = "modules/options.R") # Main module that calls the submodules for each stage of assessment for each option
source(file = "modules/roadhome.R")
source(file = "modules/roadsummary.R")
source(file = "modules/eflibrary.R")

### SUBMODULES for each assessment stage ###
source(file = "modules/baseline.R") # Baseline submodule
source(file = "modules/preconst.R") # Pre-construction submodule
source(file = "modules/embcarbon.R")
source(file = "modules/const.R")
source(file = "modules/use.R")
source(file = "modules/useremis.R")
source(file = "modules/useremisrail.R")
source(file = "modules/useremisgreenway.R")
source(file = "modules/maint.R")
source(file = "modules/eolife.R")
source(file = "modules/ccontrol.R")

########## MAIN APP ##########
ToolVersion <<- "0.9.0" # update this version for the emission factors update
SaveFileVersion <<- 2 # 1 ## save file v1 goes with tool version 0.7.2. Anything before that had no version embedded in the .sav file
                      ## We don't need to update this with every ToolVersion, just when alterations to the save/load logic are made, i.e. patches

##### UI #####

ui <- dashboardPage(title = "TII Carbon Tool",
                    
                    
  header = dashboardHeader(title = span(img(src="logo2.png", width = 180)), #width = 150
                           
                           # https://stackoverflow.com/questions/47569992/home-button-in-header-in-r-shiny-dashboard
                           
                           tags$li(class = "dropdown", HTML("&nbsp;"), HTML("&nbsp;")),
                           
                           tags$li(class = "dropdown", downloadButton(outputId = "downloadinputs", label = "Save Data", icon = icon("file-download")),
                                   tags$style(HTML("#downloadinputs {background-color: #333333; height: 34px;padding: 5px 14px 5px 14px;}")),
                                   tags$style(HTML("#downloadinputs:hover {background-color: #AECC53;}"))
                                   ),
                           
                           tags$li(class = "dropdown", HTML("&nbsp;"), HTML("&nbsp;")),
                           
                           tags$li(class = "dropdown", HTML("&nbsp;"), HTML("&nbsp;"), HTML("&nbsp;"), HTML("&nbsp;")),
                           
                           tags$li(class = "dropdown", fileInput2(inputId = "LoadFileInput", label = "Load Data", labelIcon = "file-upload",
                                                                 accept = ".sav", multiple = F, width = "100px", progress = F), 
                                   tags$style(HTML(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}"))),
                                                                
                           tags$li(class = "dropdown", HTML("&nbsp;"), HTML("&nbsp;"), HTML("&nbsp;"), HTML("&nbsp;"))
                           
                           ),
  
  sidebar = dashboardSidebar(collapsed = F,
                             useShinyjs(),
                             extendShinyjs(text = jsShowHideOpts, functions = c("ShowHideRoadOpts",
                                                                                "ShowHideRailOpts",
                                                                                "ShowHideGreenwayOpts")),
                             sidebarMenu(id = "sbstart",
                                         
                                         #hr(), # horizontal line to break up the sidebar sections
                                         
                                         menuItem(text = "Introduction", tabName = "Intro1", icon = intro_icon),
                                         
                                         menuItem(text = "Project Details", tabName = "Proj1", icon = proj_details_icon),
                                         
                                         menuItem(text = "Scoping", tabName = "Scoping1", icon = scoping_icon),
                                         
                                         hr(), # horizontal line to break up the sidebar sections

                                         ### ROAD OPTIONS ###
                                         # Fill out all 8 road and rail options here as per the below pattern, unless we can modularise this somehow?
                                         menuItem(text = "Road Home", tabName = "RoadHome", icon = road_home_icon),
                                         
                                         menuItem(text = "Road Option 1", tabName = "RoadOpt1", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero1", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro1", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro1", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro1", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero1", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro1", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro1", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero1", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Road Option 2", tabName = "RoadOpt2", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero2", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro2", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro2", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro2", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero2", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro2", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro2", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero2", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Road Option 3", tabName = "RoadOpt3", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero3", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro3", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro3", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro3", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero3", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro3", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro3", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero3", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Road Option 4", tabName = "RoadOpt4", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero4", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro4", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro4", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro4", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero4", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro4", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro4", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero4", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Road Option 5", tabName = "RoadOpt5", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero5", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro5", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro5", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro5", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero5", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro5", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro5", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero5", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Road Option 6", tabName = "RoadOpt6", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero6", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro6", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro6", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro6", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero6", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro6", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro6", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero6", icon = eol_road_icon)
                                         ),

                                         menuItem(text = "Road Option 7", tabName = "RoadOpt7", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero7", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro7", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro7", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro7", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero7", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro7", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro7", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero7", icon = eol_road_icon)
                                         ),

                                         menuItem(text = "Road Option 8", tabName = "RoadOpt8", icon = road_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinero8", icon = base_road_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstro8", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro8", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constro8", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usero8", icon = use_road_icon),
                                                  menuSubItem(text = "Road User Emissions", tabName = "useremisro8", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintro8", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifero8", icon = eol_road_icon)
                                         ),

                                         # menuItem(text = "Road Option 9", tabName = "RoadOpt9", icon = road_opts_icon, startExpanded = F,
                                         #          menuSubItem(text = "Baseline Data", tabName = "baselinero9", icon = base_road_icon),
                                         #          menuSubItem(text = "Pre-Construction", tabName = "preconstro9", icon = precon_road_icon),
                                         #          menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro9", icon = emb_carbon_road_icon),
                                         #          menuSubItem(text = "Construction", tabName = "constro9", icon = constr_road_icon),
                                         #          menuSubItem(text = "Operational Use", tabName = "usero9", icon = use_road_icon),
                                         #          menuSubItem(text = "Road User Emissions", tabName = "useremisro9", icon = user_emis_road_icon),
                                         #          menuSubItem(text = "Maintenance", tabName = "maintro9", icon = maint_road_icon),
                                         #          menuSubItem(text = "End-of-Life", tabName = "eolifero9", icon = eol_road_icon)
                                         # ),
                                         # 
                                         # menuItem(text = "Road Option 10", tabName = "RoadOpt10", icon = road_opts_icon, startExpanded = F,
                                         #          menuSubItem(text = "Baseline Data", tabName = "baselinero10", icon = base_road_icon),
                                         #          menuSubItem(text = "Pre-Construction", tabName = "preconstro10", icon = precon_road_icon),
                                         #          menuSubItem(text = "Embodied Carbon", tabName = "embcarbonro10", icon = emb_carbon_road_icon),
                                         #          menuSubItem(text = "Construction", tabName = "constro10", icon = constr_road_icon),
                                         #          menuSubItem(text = "Operational Use", tabName = "usero10", icon = use_road_icon),
                                         #          menuSubItem(text = "Road User Emissions", tabName = "useremisro10", icon = user_emis_road_icon),
                                         #          menuSubItem(text = "Maintenance", tabName = "maintro10", icon = maint_road_icon),
                                         #          menuSubItem(text = "End-of-Life", tabName = "eolifero10", icon = eol_road_icon)
                                         # ),

                                         
                                         menuItem(text = "Road Summary", tabName = "RoadSummary", icon = road_summary_icon),
                                         
                                         hr(),
                                         
                                         ### RAIL OPTIONS ###
                                         menuItem(text = "Light Rail Home", tabName = "RailHome", icon = rail_home_icon),
                                         
                                         menuItem(text = "Light Rail Option 1", tabName = "RailOpt1", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera1", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra1", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra1", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra1", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera1", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra1", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra1", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera1", icon = eol_rail_icon)
                                         ),
                                         
                                         menuItem(text = "Light Rail Option 2", tabName = "RailOpt2", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera2", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra2", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra2", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra2", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera2", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra2", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra2", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera2", icon = eol_rail_icon)
                                         ),
                                         
                                         menuItem(text = "Light Rail Option 3", tabName = "RailOpt3", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera3", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra3", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra3", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra3", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera3", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra3", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra3", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera3", icon = eol_rail_icon)
                                         ),
                                         
                                         menuItem(text = "Light Rail Option 4", tabName = "RailOpt4", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera4", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra4", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra4", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra4", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera4", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra4", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra4", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera4", icon = eol_rail_icon)
                                         ),
                                         
                                         menuItem(text = "Light Rail Option 5", tabName = "RailOpt5", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera5", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra5", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra5", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra5", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera5", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra5", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra5", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera5", icon = eol_rail_icon)
                                         ),
                                         
                                         menuItem(text = "Light Rail Option 6", tabName = "RailOpt6", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera6", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra6", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra6", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra6", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera6", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra6", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra6", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera6", icon = eol_rail_icon)
                                         ),

                                         menuItem(text = "Light Rail Option 7", tabName = "RailOpt7", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera7", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra7", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra7", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra7", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera7", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra7", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra7", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera7", icon = eol_rail_icon)
                                         ),

                                         menuItem(text = "Light Rail Option 8", tabName = "RailOpt8", icon = rail_opts_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinera8", icon = base_rail_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstra8", icon = precon_rail_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra8", icon = emb_carbon_rail_icon),
                                                  menuSubItem(text = "Construction", tabName = "constra8", icon = constr_rail_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usera8", icon = use_rail_icon),
                                                  menuSubItem(text = "Rail User Emissions", tabName = "useremisra8", icon = user_emis_rail_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintra8", icon = maint_rail_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifera8", icon = eol_rail_icon)
                                         ),

                                         # menuItem(text = "Light Rail Option 9", tabName = "RailOpt9", icon = rail_opts_icon, startExpanded = F,
                                         #          menuSubItem(text = "Baseline Data", tabName = "baselinera9", icon = base_rail_icon),
                                         #          menuSubItem(text = "Pre-Construction", tabName = "preconstra9", icon = precon_rail_icon),
                                         #          menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra9", icon = emb_carbon_rail_icon),
                                         #          menuSubItem(text = "Construction", tabName = "constra9", icon = constr_rail_icon),
                                         #          menuSubItem(text = "Operational Use", tabName = "usera9", icon = use_rail_icon),
                                         #          menuSubItem(text = "Rail User Emissions", tabName = "useremisra9", icon = user_emis_rail_icon),
                                         #          menuSubItem(text = "Maintenance", tabName = "maintra9", icon = maint_rail_icon),
                                         #          menuSubItem(text = "End-of-Life", tabName = "eolifera9", icon = eol_rail_icon)
                                         # ),
                                         # 
                                         # menuItem(text = "Light Rail Option 10", tabName = "RailOpt10", icon = rail_opts_icon, startExpanded = F,
                                         #          menuSubItem(text = "Baseline Data", tabName = "baselinera10", icon = base_rail_icon),
                                         #          menuSubItem(text = "Pre-Construction", tabName = "preconstra10", icon = precon_rail_icon),
                                         #          menuSubItem(text = "Embodied Carbon", tabName = "embcarbonra10", icon = emb_carbon_rail_icon),
                                         #          menuSubItem(text = "Construction", tabName = "constra10", icon = constr_rail_icon),
                                         #          menuSubItem(text = "Operational Use", tabName = "usera10", icon = use_rail_icon),
                                         #          menuSubItem(text = "Rail User Emissions", tabName = "useremisra10", icon = user_emis_rail_icon),
                                         #          menuSubItem(text = "Maintenance", tabName = "maintra10", icon = maint_rail_icon),
                                         #          menuSubItem(text = "End-of-Life", tabName = "eolifera10", icon = eol_rail_icon)
                                         # ),
                                         
                                         
                                         menuItem(text = "Light Rail Summary", tabName = "RailSummary", icon = rail_summary_icon),
                                         
                                         hr(),
                                         
                                         ###GREENWAY OPTIONS###
                                         
                                         menuItem(text = "Greenway Home", tabName = "GreenwayHome", icon = gway_home_icon),
                                         
                                         menuItem(text = "Greenway Option 1", tabName = "GreenwayOpt1", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw1", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw1", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw1", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw1", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw1", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw1", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw1", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw1", icon = eol_road_icon)
                                         ),

                                         menuItem(text = "Greenway Option 2", tabName = "GreenwayOpt2", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw2", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw2", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw2", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw2", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw2", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw2", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw2", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw2", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Greenway Option 3", tabName = "GreenwayOpt3", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw3", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw3", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw3", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw3", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw3", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw3", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw3", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw3", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Greenway Option 4", tabName = "GreenwayOpt4", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw4", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw4", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw4", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw4", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw4", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw4", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw4", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw4", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Greenway Option 5", tabName = "GreenwayOpt5", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw5", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw5", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw5", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw5", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw5", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw5", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw5", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw5", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Greenway Option 6", tabName = "GreenwayOpt6", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw6", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw6", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw6", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw6", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw6", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw6", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw6", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw6", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Greenway Option 7", tabName = "GreenwayOpt7", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw7", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw7", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw7", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw7", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw7", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw7", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw7", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw7", icon = eol_road_icon)
                                         ),
                                         
                                         menuItem(text = "Greenway Option 8", tabName = "GreenwayOpt8", icon = gway_home_icon, startExpanded = F,
                                                  menuSubItem(text = "Baseline Data", tabName = "baselinegw8", icon = base_gway_icon),
                                                  menuSubItem(text = "Pre-Construction", tabName = "preconstgw8", icon = precon_road_icon),
                                                  menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw8", icon = emb_carbon_road_icon),
                                                  menuSubItem(text = "Construction", tabName = "constgw8", icon = constr_road_icon),
                                                  menuSubItem(text = "Operational Use", tabName = "usegw8", icon = use_road_icon),
                                                  menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw8", icon = user_emis_road_icon),
                                                  menuSubItem(text = "Maintenance", tabName = "maintgw8", icon = maint_road_icon),
                                                  menuSubItem(text = "End-of-Life", tabName = "eolifegw8", icon = eol_road_icon)
                                         ),
                                         
                                         # menuItem(text = "Greenway Option 9", tabName = "GreenwayOpt9", icon = gway_home_icon, startExpanded = F,
                                         #          menuSubItem(text = "Baseline Data", tabName = "baselinegw9", icon = base_gway_icon),
                                         #          menuSubItem(text = "Pre-Construction", tabName = "preconstgw9", icon = precon_road_icon),
                                         #          menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw9", icon = emb_carbon_road_icon),
                                         #          menuSubItem(text = "Construction", tabName = "constgw9", icon = constr_road_icon),
                                         #          menuSubItem(text = "Operational Use", tabName = "usegw9", icon = use_road_icon),
                                         #          menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw9", icon = user_emis_road_icon),
                                         #          menuSubItem(text = "Maintenance", tabName = "maintgw9", icon = maint_road_icon),
                                         #          menuSubItem(text = "End-of-Life", tabName = "eolifegw9", icon = eol_road_icon)
                                         # ),
                                         # 
                                         # menuItem(text = "Greenway Option 10", tabName = "GreenwayOpt10", icon = gway_home_icon, startExpanded = F,
                                         #          menuSubItem(text = "Baseline Data", tabName = "baselinegw10", icon = base_gway_icon),
                                         #          menuSubItem(text = "Pre-Construction", tabName = "preconstgw10", icon = precon_road_icon),
                                         #          menuSubItem(text = "Embodied Carbon", tabName = "embcarbongw10", icon = emb_carbon_road_icon),
                                         #          menuSubItem(text = "Construction", tabName = "constgw10", icon = constr_road_icon),
                                         #          menuSubItem(text = "Operational Use", tabName = "usegw10", icon = use_road_icon),
                                         #          menuSubItem(text = "Greenway User Emissions", tabName = "useremisgw10", icon = user_emis_road_icon),
                                         #          menuSubItem(text = "Maintenance", tabName = "maintgw10", icon = maint_road_icon),
                                         #          menuSubItem(text = "End-of-Life", tabName = "eolifegw10", icon = eol_road_icon)
                                         # ),
                                         
                                         menuItem(text = "Greenway Summary", tabName = "GreenwaySummary", icon = gway_summary_icon),
                                         
                                         hr(),
                                         menuItem(text = "Emission Factors", tabName = "EFlibrary", icon = eflibrary_icon),
                                         menuItem(text = "Change Control", tabName = "CControl", icon = ccontrol_icon),
                                         
                                         hr(),
                                         # downloadButton(outputId = "downloadguide", label = "Download PDF Guide", icon = icon("file-download"))
                                         tagList(a(HTML("&nbsp;&nbsp;Download PDF Guide"), href="https://www.tiipublications.ie/document/?id=3219", target="_blank"))
                                         
                             )
                             
  ),

  body = dashboardBody(useShinyjs(), #useShinyalert(),
                       
                       use_waiter(),
                       waiter_show_on_load(loading_spinner),
                       
                       #customTheme,
                       includeCSS("www/Theme2.css"),
                       ### changing theme
                       #dashboardthemes::shinyDashboardThemes(
                      #   theme = "blue_gradient"
                       #),
                      
                      tags$style("
.nav-tabs-custom .nav-tabs li a:hover {
border-color: transparent;
background-color: #AECC53;
border-radius: 12px;
color: #000;

}
.nav-tabs-custom .nav-tabs li a {
border-color: transparent;
background-color: #333333;
border-radius: 12px;
color: #fff;
}"),
#  #008768
                      
                       
    options_ui(id = "Opts"), # run the UI side of options module and all submodules within it
    extendShinyjs(text = jsTrimDrop, functions = c()),
    tags$style(button_style)
  )
)

##### SERVER #####
server <- function(input, output, session){
  
  cat(file=stderr(),paste0(Sys.time(), " *** start of server function:",session$token, "**** \n"))
  
  cat(file=stderr(), "*** Session started:",session$token, "**** \n")
  
   session$onSessionEnded(function() {
    cat(file=stderr(), "*** Session ended:",session$token, "**** \n")
  })


  efs_react <- reactiveValues(data = efs)
  cat(file=stderr(), "*** efs_react:",session$token, "**** \n")

  efs_materialroad_userinput <- reactiveValues(data = efs$Material_Road[Manual == "MANUAL"]) # blank DF on start up because there should eb no manual EFs in the excel workbook
   cat(file=stderr(), "*** efs_materialroad_userinput:",session$token, "**** \n")
  

  efs_materialrail_userinput <- reactiveValues(data = efs$Material_Rail[Manual == "MANUAL"])
   cat(file=stderr(), "*** efs_materialrail_userinput:",session$token, "**** \n")
   

   # new EF
   # efs_react_new <- reactiveValues(data = efs_new)
   # cat(file=stderr(), "*** efs_react_new:",session$token, "**** \n")

   # efs_new_materialroad_userinput <- reactiveValues(data = efs_new$Material_Road[Manual == "MANUAL"]) # blank DF on start up because there should eb no manual EFs in the excel workbook
   # cat(file=stderr(), "*** efs_new_materialroad_userinput:",session$token, "**** \n")
  
  
  # Global reactivevalues to hold loaded SAV file data and pass to modules/submodules
  appR_returned <- reactiveValues(data = NULL, loadReact = NULL)
  cat(file=stderr(), "*** appR_returned:",session$token, "**** \n")

  
  load_data_react_2 <- reactive(input$load_button_ok_2)
  cat(file=stderr(), "*** load_data_react_2:",session$token, "**** \n")
 

  # server side of main module that calls all submodules, and returns 
  options_serv <- options_server("Opts", appR_returned, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
   cat(file=stderr(), paste0(Sys.time()," *** options_serv:",session$token, "**** \n"))

  
  # acts as a trigger when download button is used
  download_button_trigger <- reactiveValues(download_flag = 0)
  cat(file=stderr(), "*** download_button_trigger:",session$token, "**** \n")
  
  
  # Download button handler -----
  output$downloadinputs <- downloadHandler(
    filename = function() {
      paste("TII-data-", format(Sys.time(), "%Y-%m-%d-%H%M"), ".sav", sep="")
    },
    content = function(filename){
      
      #showModal(modalDialog("Downloading data", footer=NULL))
      #on.exit(removeModal())
      
      inputs <- NULL
      for (i in 1:nrow(collatedShinyInputs)){
        collatedShinyInputs$Value[i] <- input[[collatedShinyInputs[i,1]]]
      }
      
      ##### build save file with parameters and corresp. values
      inputs_data_frame <- collatedShinyInputs[-1]
      
      ##### pull in data from rhandsontables
      for (i in 1:nrow(collatedTableLoadFiles)){
        #assign(collatedTableLoadFiles[i,1],hot_to_r(input[[collatedTableLoadFiles[i,2]]]))
        #assign(collatedTableLoadFiles[i,1], input[[collatedTableLoadFiles[i,2]]])
        #if (is.null(get(collatedTableLoadFiles[i,1]))){
          assign(collatedTableLoadFiles[i,1], options_serv[[collatedTableLoadFiles[i,1]]])
        #}
      }
      
      collatedTableLoadFiles[nrow(collatedTableLoadFiles)+1,] <- "inputs_data_frame"
      dfstoSave <- mget(unlist(collatedTableLoadFiles[1]))
      # add manual EF inputs to save file here:
      dfstoSave$efs_materialroad_userinput <- efs_materialroad_userinput$data
      dfstoSave$efs_materialrail_userinput <- efs_materialrail_userinput$data
      
      #shinyalert("File Saved", timer = 1500, showConfirmButton = T, animation = T, closeOnEsc = T, type = "success")
      #shinyjs::delay(1000, 1)
      dfstoSave$toolVersion <- ToolVersion
      dfstoSave$saveVersion <- SaveFileVersion
      
      #browser()
      
      save(dfstoSave, file = filename) # save 'dfstoSave' to the .SAV file
      
      download_button_trigger$download_flag <- download_button_trigger$download_flag + 1
      
      #if(download_button_trigger$download_flag > 0){
      #  shinyjs::alert("File downloaded!")
      #}
    }
  )
  

  cat(file=stderr(), "*** output$downloadinputs:",session$token, "**** \n")
  
  
  # observeEvent(download_button_trigger$download_flag, {
  #   shinyalert("File Saved", timer = 1500, showConfirmButton = T, animation = T, closeOnEsc = T, type = "success")
  # }, suspended = T)
  
  cat(file=stderr(), "*** output$observeEvent(download_button_trigger$download_flag:",session$token, "**** \n")
 
  
  # Import file to load -----
  # NEED TO PUT ERROR CATCH IN FOR CANCELLED FILE SLECTED
  observeEvent(input$LoadFileInput$name, {
    
    appR_returned$data <- NULL#  clear everything prior to load
    
    load(input$LoadFileInput$datapath) # loads 'dfstoSave' into the environment
    
    ### Tracking elements 23-AUG-2023
    appR_returned$token <- session$token                              # archive session token ID
    appR_returned$loadReact <- "Go"
    
    cat(file=stderr(), "*** App.r load observer app version 0.6.16 **** \n")                               # print session token ID
    cat(file=stderr(), "*** App.r load observer session token:",session$token, "**** \n")                  # print session token ID
    
    #input$LoadFileInput$datapath <- NULL
    ### End
    
    appR_returned$data$saveVersion <- 0
    
    appR_returned$data <- dfstoSave # 
    
    # check savefile version
    if (appR_returned$data$saveVersion < 2) {
      print("Savefile version NOT up to date - please check inputs")
    } else {
      print("Savefile Version 2 - up to date")
    }
    
    # load user input manual EFs
    
    print("ObserveEvent   APP.R   load_data_react()")
    modInputs <- c("NumRoadOpts", "NumRailOpts", "NumGreenwayOpts")
    loadedInput <- appR_returned$data$inputs_data_frame

    for (i in 1:length(modInputs)){
      loadedInputValue <- loadedInput %>% filter(idInput %in% modInputs[i]) %>% pull(4)
      updateSelectInput(session, input = modInputs[i], selected = loadedInputValue)
    }
    
    
    if (nrow(appR_returned$data$inputs_data_frame %>% filter(idInput %in% "NumGreenwayOpts")) == 0){
      load("global/New_Load_Inputs_DF.Rdata")
      Old_Load_Inputs_DF <- appR_returned$data$inputs_data_frame
      # could the lines below be piped (%>%), at least partially?
      Loaded_Data_Update <- left_join(New_Load_Inputs_DF, Old_Load_Inputs_DF, by = join_by(Opts, Module, idInput))
      Loaded_Data_Update <- dplyr::mutate(Loaded_Data_Update, Value.y = coalesce(Value.y, Value.x))
      Loaded_Data_Update <- Loaded_Data_Update[-4]
      Loaded_Data_Update <- dplyr::rename(Loaded_Data_Update, Value = Value.y)
      appR_returned$data$inputs_data_frame <- Loaded_Data_Update
      }
    #browser()
    # # load user input manual EFs
    #efs_materialroad_userinput$data <<- rbind(efs_materialroad_userinput$data, dfstoSave$efs_materialroad_userinput)
    #efs_materialrail_userinput$data <<- rbind(efs_materialrail_userinput$data, dfstoSave$efs_materialrail_userinput)

    efs_react$data$Material_Road <- unique(rbind(efs_react$data$Material_Road, dfstoSave$efs_materialroad_userinput)) # this is all road materials, used in drop down select in emb carbon mod. Unique() is to patch earlier version where duplicates were made
    efs_react$data$Material_Rail <- unique(rbind(efs_react$data$Material_Rail, dfstoSave$efs_materialrail_userinput))
    
    efs_materialroad_userinput$data <- unique(rbind(efs_materialroad_userinput$data, dfstoSave$efs_materialroad_userinput)) # this is MAN road materials only, used in drop down select in emb carbon mod. Unique() is to patch earlier version where duplicates were made
    efs_materialrail_userinput$data <- unique(rbind(efs_materialrail_userinput$data, dfstoSave$efs_materialrail_userinput))
    
    shinyalert("File Loaded", timer = 2000, showConfirmButton = T, animation = F, closeOnEsc = T, immediate = T, type = "success", inputId = "load_button_ok_2")
    
  })

  
   cat(file=stderr(), "***  observeEvent(input$LoadFileInput$name:",session$token, "**** \n")
  

  # Download button handler for PDF Guide -----
  # output$downloadguide <- downloadHandler(
  #   filename = function() {
  #     paste("TII-Carbon-Tool-Guide.pdf", sep="")
  #   },
  #   content = function(file){
  #     GET("https://www.tiipublications.ie/document/?id=3219", write_disk(file))
  #   }
  # )
  
   # cat(file=stderr(), "***  output$downloadguide:",session$token, "**** \n")

  
  observeEvent(load_data_react_2(), {
    print("ObserveEvent   APP.R   load_data_react_2()")
    appR_returned$loadReact <- NULL
  })



  cat(file=stderr(), paste0(Sys.time()," ***   observeEvent(load_data_react():",session$token, "**** \n"))
   
  appR_returned$num_road_opts_react <- reactive(as.numeric(input$NumRoadOpts))
  appR_returned$num_rail_opts_react <- reactive(as.numeric(input$NumRailOpts))
  appR_returned$num_greenway_opts_react <- reactive(as.numeric(input$NumGreenwayOpts))																	 
  
  # Show/hide menu items based on the number of rail/road options requested  
  observeEvent(input$NumRoadOpts, { # need one observeEvent each for road and rail
    js$ShowHideRoadOpts(minOpts = 1,maxOpts = total_num_options, numOpts = input$NumRoadOpts)
  })
  
  # Show/hide menu items based on the number of rail/road options requested  
  observeEvent(input$NumRailOpts, { # need one observeEvent each for road and rail
    js$ShowHideRailOpts(minOpts = 1,maxOpts = total_num_options, numOpts = input$NumRailOpts)
  })

  observeEvent(input$NumGreenwayOpts, { # need one observeEvent each for road and rail
    js$ShowHideGreenwayOpts(minOpts = 1,maxOpts = total_num_options, numOpts = input$NumGreenwayOpts)
 })	
    
    waiter_hide()

   
  cat(file=stderr(), paste0(Sys.time()," *** end of server function:",session$token, "**** \n"))
  
  

}

shinyApp(ui,server)

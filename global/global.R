##### global.R ######################################################################################################################

# Last modified by Julian Mann (25/10/2021)
# Updated by A Thorpe (11/07/2023) - reduce number of options to 8. Removed shinyDashboardThemeDIY
#                                    code as this id done via CSS file now
#####################################################################################################################################

# File contains global variables and functions defined for the TII shiny app

##### LIBRARIES #####
# library(shiny)
# library(shinydashboard)
# library(shinyjs)
# library(shinyBS)
# library(shinyWidgets)
# library(shinyalert)
# library(dashboardthemes)
# #library(openxlsx)
# library(rio)
# library(data.table)
# library(dplyr)
# library(rhandsontable)
# library(DT)
# library(plotly)
# library(ggplot2)
# library(waiter)
# library(tcltk)
# library(zip)
#---------------------------

total_num_options <<- 8 # define total number of possible road or rail options allowed within the app
mailto <- a("Carbon Tool Support", href="mailto:REMandCarbonToolSupport@aecom.com?subject=REM Support:")

# based on the Shiny fileInput function
fileInput2 <- function(inputId, label = NULL, labelIcon = NULL, multiple = FALSE, 
                       accept = NULL, width = NULL, progress = TRUE, ...) {
  # add class fileinput_2 defined in UI to hide the inputTag
  inputTag <- tags$input(id = inputId, name = inputId, type = "file", 
                         class = "fileinput_2")
  if (multiple) 
    inputTag$attribs$multiple <- "multiple"
  if (length(accept) > 0) 
    inputTag$attribs$accept <- paste(accept, collapse = ",")
  
  div(..., style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"), 
      inputTag,
      # label customized with an action button
      tags$label(`for` = inputId, div(icon(labelIcon), label, 
                                      class = "btn btn-default action-button")),
      # optionally display a progress bar
      if(progress)
        tags$div(id = paste(inputId, "_progress", sep = ""), 
                 class = "progress shiny-file-input-progress", 
                 tags$div(class = "progress-bar")
        )
  )
}

########## STYLING #########

loading_spinner <- tagList(
  spin_chasing_dots(),
  span("Loading TII Carbon Assessment Tool...", style="color:white;")
)


## Overall App theme #################
# Using AECOM Earth Green #008768, Midnight Teal #00353e
# and Ocean Teal #009a9b

aecom_earth_green <- "rgb(0,135,104)" # HEX: #008768
aecom_lime_green <- "rgb(174,204,83)" # HEX: #AECC53
aecom_midnight_teal <- "rgb(0,53,62)" # HEX: #00353E
light_grey_colour <- "rgb(238,238,238)"
dark_grey_colour <- "rgb(51,51,51)"   # HEX: #333333
white_colour <- "rgb(255,255,255)"    # HEX: #FFF
black_colour <- "rgb(0,0,0)"          # HEX: #000


#toggle_guid_btn_style <- "color: #fff; background-color: #008768; border-color: #008768" # styling for guidance notes toggle button 
toggle_guid_btn_style <- "color: #fff; background-color: #333333; border-color: #333333" # styling for guidance notes toggle button 

#button_style <- ".btn-default {color: #fff; background-color: #008768;}"
button_style <- ".btn-default.active.focus {color: #fff; background-color: #333333;}
.btn-default.active {color: #fff; background-color: #333333;}"



# 
logo_back_colour <- light_grey_colour
#
sidebar_back_colour <- dark_grey_colour
sidebar_tab_back_colour_selected <- sidebar_tab_back_colour_hover <- aecom_lime_green
sidebar_tab_text_colour_selected <- sidebar_tab_text_colour_hover <- black_colour
#
tab_box_tab_colour <- aecom_lime_green
tab_box_tab_text_colour <- tab_box_tab_text_colour_selected <- black_colour
#
button_back_colour <- dark_grey_colour
button_text_colour <- white_colour
button_back_colour_hover <- aecom_lime_green
button_text_colour_hover <- black_colour
#
textbox_back_colour <- table_back_colour <- tab_box_back_colour <- white_colour


### creating custom theme object
# customTheme <- shinyDashboardThemeDIY(
#   
#   ### general
#   appFontFamily = "Arial"
#   ,appFontColor = "rgb(0,0,0)"
#   ,primaryFontColor = "rgb(0,0,0)"
#   ,infoFontColor = "rgb(0,0,0)"
#   ,successFontColor = "rgb(0,0,0)"
#   ,warningFontColor = "rgb(0,0,0)"
#   ,dangerFontColor = "rgb(0,0,0)"
#   ,bodyBackColor = "rgb(248,248,248)"
#   
#   ### header
#   ,logoBackColor = logo_back_colour
#   
#   ,headerButtonBackColor = "rgb(238,238,238)"
#   ,headerButtonIconColor = "rgb(75,75,75)"
#   ,headerButtonBackColorHover = "rgb(210,210,210)"
#   ,headerButtonIconColorHover = "rgb(0,0,0)"
#   
#   ,headerBackColor = "rgb(238,238,238)"
#   ,headerBoxShadowColor = "#aaaaaa"
#   ,headerBoxShadowSize = "2px 2px 2px"
#   
#   ### sidebar
#   ,sidebarBackColor = sidebar_back_colour # aecom_earth_green
#   ,sidebarPadding = 0
#   
#   ,sidebarMenuBackColor = "transparent"
#   ,sidebarMenuPadding = 0
#   ,sidebarMenuBorderRadius = "5px"
#   
#   ,sidebarShadowRadius = "3px 5px 5px"
#   ,sidebarShadowColor = "#aaaaaa"
#   
#   ,sidebarUserTextColor = black_colour # "rgb(255,255,255)"
#   
#   ,sidebarSearchBackColor = "rgb(55,72,80)"
#   ,sidebarSearchIconColor = "rgb(153,153,153)"
#   ,sidebarSearchBorderColor = "rgb(55,72,80)"
#   
#   ,sidebarTabTextColor = "rgb(255,255,255)"
#   ,sidebarTabTextSize = 14
#   ,sidebarTabBorderStyle = "none none solid none"
#   ,sidebarTabBorderColor = "rgb(35,106,135)"
#   ,sidebarTabBorderWidth = 0
# 
#   ,sidebarTabBackColorSelected = sidebar_tab_back_colour_selected
#   ,sidebarTabTextColorSelected = sidebar_tab_text_colour_selected
#   ,sidebarTabRadiusSelected = "0px 20px 20px 0px"
#   
#   ,sidebarTabBackColorHover = sidebar_tab_back_colour_hover
#   ,sidebarTabTextColorHover = sidebar_tab_text_colour_hover
#   ,sidebarTabBorderStyleHover = "none none solid none"
#   ,sidebarTabBorderColorHover = "rgb(75,126,151)"
#   ,sidebarTabBorderWidthHover = 0
#   ,sidebarTabRadiusHover = "0px 20px 20px 0px"
#   
#   ### boxes
#   ,boxBackColor = "rgb(255,255,255)"
#   ,boxBorderRadius = 10
#   ,boxShadowSize = "3px 3px 3px 3px"
#   ,boxShadowColor = "rgba(0,0,0,.1)"
#   ,boxTitleSize = 14
#   ,boxDefaultColor = "rgb(210,214,220)"
#   ,boxPrimaryColor = "rgba(44,222,235,1)"
#   ,boxInfoColor = "rgb(210,214,220)"
#   ,boxSuccessColor = "rgba(0,255,213,1)"
#   ,boxWarningColor = "rgb(244,156,104)"
#   ,boxDangerColor = "rgb(255,88,55)"
#   
#   ,tabBoxTabColor = tab_box_tab_colour # aecom_midnight_teal # "#008768"
#   ,tabBoxTabTextSize = 14
#   ,tabBoxTabTextColor = tab_box_tab_text_colour # "rgb(0,0,0)"
#   ,tabBoxTabTextColorSelected = tab_box_tab_text_colour_selected # "#FFF"
#   ,tabBoxBackColor = tab_box_back_colour # "rgb(255,255,255)"
#   ,tabBoxHighlightColor = "rgb(210,210,210)" # "transparent"
#   ,tabBoxBorderRadius = 10
#   
#   ### inputs
#   ,buttonBackColor = button_back_colour # aecom_earth_green
#   ,buttonTextColor = button_text_colour # "#FFF"
#   ,buttonBorderColor = "rgb(200,200,200)"
#   ,buttonBorderRadius = 5
# 
#   ,buttonBackColorHover = button_back_colour_hover # aecom_midnight_teal
#   ,buttonTextColorHover = button_text_colour_hover # "#FFF"
#   ,buttonBorderColorHover = "rgb(200,200,200)"
#   
#   ,textboxBackColor = textbox_back_colour # "rgb(255,255,255)"
#   ,textboxBorderColor = "rgb(200,200,200)"
#   ,textboxBorderRadius = 5
#   ,textboxBackColorSelect = "rgb(245,245,245)"
#   ,textboxBorderColorSelect = "rgb(200,200,200)"
#   
#   ### tables
#   ,tableBackColor = table_back_colour # "rgb(255,255,255)"
#   ,tableBorderColor = "rgb(240,240,240)"
#   ,tableBorderTopSize = 1
#   ,tableBorderRowSize = 1
#   
# )


########## ICONS ##########
intro_icon <- icon("door-open")
proj_details_icon <- icon("info-circle")
scoping_icon <- icon("microscope")

road_home_icon <- icon("road")
rail_home_icon <- icon("train")
gway_home_icon <- icon("bicycle")
road_opts_icon <- icon("car")
rail_opts_icon <- icon("subway")
road_summary_icon <- rail_summary_icon <- gway_summary_icon <- icon("dashboard")

base_road_icon <- base_rail_icon <- base_gway_icon <- icon("pencil-alt")
precon_road_icon <- precon_rail_icon <- icon("snowplow")
constr_road_icon <- constr_rail_icon <- icon("hard-hat")
emb_carbon_road_icon <- emb_carbon_rail_icon <- icon("building") # icon("tree")
use_road_icon <- icon("car")
use_rail_icon <- icon("train")
user_emis_road_icon <- user_emis_rail_icon <- icon("users")
maint_road_icon <- maint_rail_icon <- icon("tools")
waste_road_icon <- waste_rail_icon <- icon("recycle")

eol_road_icon <- eol_rail_icon <- icon("hourglass-end")

eflibrary_icon <- icon("calculator")
ccontrol_icon <- icon("gear")
addcustom_icon <- icon("plus")

tooltipicon <- icon("box-open")							   
########## JQuery Read Statements ########
jsShowHideOpts <- HTML(readr::read_file("www/ShowHideOpts.js"))
jsTrimDrop <- HTML(readr::read_file("www/trimdrop.js"))

##### EMISSION FACTORS #####
#efs <<- rio::import_list("emission_factors/Emission_Factors.xlsx", setclass = "data.table") # imports all EF data as a list
#efs <<- rio::import_list("emission_factors/Emission_Factors_May2025.xlsx", setclass = "data.table") # imports all EF data as a list
# efs <<- rio::import_list("emission_factors/Emission_Factors_May2025_CompGroup.xlsx", setclass = "data.table") # imports all EF data as a list
efs <<- rio::import_list("emission_factors/Emission_Factors_13-MAR-2026.xlsx", setclass = "data.table") # imports all EF data as a list



fuels <- efs$Fuel
water_use <- efs$Water				 

embodied_carbon_materials_flag <- data.table(Number = c(NA,1,2,3),
                                             `Flag Text` = c("","This is a high impact material - to review alternative similar materials 
                                             that could be used instead please navigate to the Material Comparisons page",
                                               "This is a material associated with a high volume of use, and a high carbon impact 
                                               - to review alternative similar materials that could be used instead please navigate 
                                               to the Material Comparisons page",
                                               "This is a material often associated with a high level of use - to review alternative 
                                               similar materials with a lower impact that could be used instead please navigate 
                                               to the Material Comparisons page"))


##### RHANDSONTABLE #####

# Global setting for number of rows to initialise rhandsontables with
rhot_rows = 5
# string containing CSS text for styling to be applied to rhandsontables
#rhandsontable_headstyle <- " table {font: 16px 'Lucida Grande', 'Helvetica', 'Arial', sans-serif;} th {font-weight: bold; font-size: 18px; color: #ffffff; background-color: #00353e;}"

#  #008768

rhandsontable_headstyle <- "
.handsontable th {
  background-color: #333333;
  font-weight: bold;
  font-size: 14px;
  color: #ffffff;
  text-align: left;
}
 .handsontable tbody {
   font-size: 14px;
   color: black;
   text-align: left;
   word-wrap: break-word;
}
.handsontable.listbox td.htDimmed {
   color: black;
   overflow: visible;
}
.handsontable.listbox tr:hover td {
   background: #AECC53;
   color: #ffffff;
   overflow: visible;
}
.handsontable.listbox tr td.current {
   background: #333333;
   overflow: visible;
}"

rhandsontable_defaultheight <- 300 # default height (pixels?) for rhandsontables throughout app


##### MODULES/SUBMODULES #####

# # initialise dummy data frame to combine submodule outputs from each stage
# DF_the_returned_kgCO2e <- data.frame(Stage = c("Pre-Construction","Pre-Construction","Pre-Construction","Pre-Construction",
#                                         "Embodied Carbon","Embodied Carbon"),
#                               Measure = c("Clearance & Demolition Activities","Land Use Change & Vegetation Loss",
#                                           "Water Use","Pre Construction Total",
#                                           "Raw Materials Embodied Carbon","Embodied Carbon Total"),
#                               Value = c(0.0,0.0,0.0,0.0,0.0,0.0),
#                               stringsAsFactors = F, check.names = FALSE)

##### PROJECT DETAILS #####

road_proj_phase_list <- list("Road Phase 0: Programme Overview & Requirement Definition", 
                              "Road Phase 1: Scheme Concept & Feasibility", 
                              "Road Phase 2: Option Selection", 
                              "Road Phase 3: Design & Environmental Evaluation", 
                              "Road Phase 4: Statutory Processes", 
                              "Road Phase 5: Enabling & Procurement", 
                              "Road Phase 6: Construction & Implementation", 
                              "Road Phase 7: Close out & Review")

# rail_proj_phase_list <- list("Light Rail Phase 0: Scope and Application",
#                               "Light Rail Phase 1: Scheme Concept & Option Selection", 
#                               "Light Rail Phase 2: Preliminary Design", 
#                               "Light Rail Phase 3: Statutory Processes", 
#                               "Light Rail Phase 4: Detailed Design & Tender Process", 
#                               "Light Rail Phase 5: Construction & Implementation", 
#                               "Light Rail Phase 6: Close out & Review")

rail_proj_phase_list <- list("Light Rail Phase 1: Scope and Purpose", 
                             "Light Rail Phase 2: Concept Development and Options Selection", 
                             "Light Rail Phase 3: Preliminary Design", 
                             "Light Rail Phase 4: Statutory Processes", 
                             "Light Rail Phase 5: Detailed Design and Procurement", 
                             "Light Rail Phase 6: Construction and Implementation", 
                             "Light Rail Phase 7: Close-out and Review")

greenway_proj_phase_list <- list("Greenway Phase 0: Programme Overview & Requirement Definition", 
                              "Greenway Phase 1: Scheme Concept & Feasibility", 
                              "Greenway Phase 2: Option Selection", 
                              "Greenway Phase 3: Design & Environmental Evaluation", 
                              "Greenway Phase 4: Statutory Processes", 
                              "Greenway Phase 5: Enabling & Procurement", 
                              "Greenway Phase 6: Construction & Implementation", 
                              "Greenway Phase 7: Close out & Review")
							  
##### EMISSIONS DISPLAYED IN TABS AND MENUS #####
Emissions_DPlaces_tabs <- 2
Emissions_DPlaces_menus <- 2																

##### SUMMARY TABLES #####
DF_emis_breakdown <- data.table(Option = c(1:10),
                                Name = c("",""),
                                #`Pre-Construction` = c(0.0,0.0),
                                `Product Stage (A1-A3)` = c(0.0,0.0),
                                `Construction Process Stage (A4-5)` = c(0.0,0.0),
                                #`Construction Waste` = c(0.0,0.0),
                                `Operational Use (B1-B7)` = c(0.0,0.0),
                                `User Emissions (B8)` = c(0.0,0.0),
                                #`Maintenance` = c(0.0,0.0),
                                `End of Life (C1-C4)` = c(0.0,0.0),
                                Total = c(0.0,0.0),
                                stringsAsFactors = F, check.names = FALSE)


# DF_emis_detailed <- data.table(Option = c(1:10),
#                                Name = c("",""),
#                                Materials = c(0.0, 0.0),
#                                `Material Transport` = c(0.0, 0.0),
#                                `Clearance and demolition` = c(0.0, 0.0),
#                                `Land Use Change and Vegetation Loss` = c(0.0, 0.0),
#                                `Clearance and Demolition Water Use` = c(0.0, 0.0),
#                                Excavation = c(0.0, 0.0),
#                                `Construction Water Use` = c(0.0, 0.0),
#                                `Plant Use` = c(0.0, 0.0),
#                                `Construction Worker Travel to Site` = c(0.0, 0.0),
#                                `Construction Waste Disposal` = c(0.0, 0.0),
#                                `Construction Waste Transport` = c(0.0, 0.0),
#                                `Operational Energy` = c(0.0, 0.0),
#                                `Operational Water` = c(0.0, 0.0),
#                                `Operational Waste Disposal` = c(0.0, 0.0),
#                                `Operational Waste Transport` = c(0.0, 0.0),
#                                `Landscaping and Vegetation` = c(0.0, 0.0),
#                                `Maintenance Material` = c(0.0, 0.0),
#                                `Maintenance Plant` = c(0.0, 0.0),
#                                `Customer Use (Road Vehicle Use)` = c(0.0, 0.0),
#                                `Decommissioning Emissions` = c(0.0, 0.0),
#                                `Decommissioning Waste Disposal` = c(0.0, 0.0),
#                                `Decommissioning Waste Transport` = c(0.0, 0.0),
#                                `Total` = c(0.0, 0.0),
#                                stringsAsFactors = F, check.names = FALSE)
DF_emis_detailed <- data.table(Option = c(1:10),
                               Name = c("",""),
                               `Raw Material Supply and Manufacture (A1, A3)` = c(0.0, 0.0),
                               `Raw Material Transport (A2)` = c(0.0, 0.0),
                               `Construction Worker Travel to Site (A4)` = c(0.0, 0.0),
                               `Clearance and demolition (A5)` = c(0.0, 0.0),
                               `Land Use Change and Vegetation Loss (A5)` = c(0.0, 0.0),
                               `Clearance and Demolition Water Use (A5)` = c(0.0, 0.0),
                               `Excavation (A5)` = c(0.0, 0.0),
                               `Plant Use (A5)` = c(0.0, 0.0),
                               `Construction Water Use (A5)` = c(0.0, 0.0),
                               `Construction Waste Disposal (A5)` = c(0.0, 0.0),
                               `Construction Waste Transport (A5)` = c(0.0, 0.0),
                               `Landscaping and Vegetation (A5)` = c(0.0, 0.0),
                               `Operational Waste Disposal (B1)` = c(0.0, 0.0),
                               `Operational Waste Transport (B1)` = c(0.0, 0.0),
                               `Maintenance (B2-B5)` = c(0.0, 0.0),
                               `Maintenance Plant (B2-B5)` = c(0.0, 0.0),
                               `Operational Energy Use (B6)` = c(0.0, 0.0),
                               `Operational Water Use (B7)` = c(0.0, 0.0),
                               `Users Utilisation of Infrastructure (B8)` = c(0.0, 0.0),
                               `Decommissioning Emissions (C1)` = c(0.0, 0.0),
                               `Decommissioning Waste Transport (C2)` = c(0.0, 0.0),
                               `Decommissioning Waste Disposal (C3-C4)` = c(0.0, 0.0),
                               `Total` = c(0.0, 0.0),
                               stringsAsFactors = F, check.names = FALSE)

tblheader_DF_emis_detailed <- htmltools::withTags(table(
  class = 'display',
  thead(
    tr(
      th(rowspan = 2, 'Option'), #rowspan = 2, 'Option',
      th(rowspan = 2, 'Name'), #rowspan = 2, 'Name',
      th(colspan = 2, 'Product Stage (A1-A3)'),
      th(colspan = 10, 'Construction Process Stage (A4-A5)'),
      #th(colspan = 2, 'Construction Waste'),
      th(colspan = 6, 'Operational Use (B1-B7)'),
      #th(colspan = 2, 'Maintenance'),
      th(colspan = 1, 'User Emissions (B8)'),
      th(colspan = 3, 'End of Life (C1-C4)'),
      th(rowspan = 2, 'Total')
    ),
    tr(
      lapply(names(DF_emis_detailed)[3:24], th)
    )
  )
))


# DF_emis_detailed_rail <- data.table(Option = c(1:10),
#                                Name = c("",""),
#                                Materials = c(0.0, 0.0),
#                                `Material Transport` = c(0.0, 0.0),
#                                `Clearance and demolition` = c(0.0, 0.0),
#                                `Land Use Change and Vegetation Loss` = c(0.0, 0.0),
#                                `Clearance and Demolition Water Use` = c(0.0, 0.0),
#                                Excavation = c(0.0, 0.0),
#                                `Construction Water Use` = c(0.0, 0.0),
#                                `Plant Use` = c(0.0, 0.0),
#                                `Construction Worker Travel to Site` = c(0.0, 0.0),
#                                `Construction Waste Disposal` = c(0.0, 0.0),
#                                `Construction Waste Transport` = c(0.0, 0.0),
#                                `Operational Energy` = c(0.0, 0.0),
#                                `Operational Water` = c(0.0, 0.0),
#                                `Operational Waste Disposal` = c(0.0, 0.0),
#                                `Operational Waste Transport` = c(0.0, 0.0),
#                                `Landscaping and Vegetation` = c(0.0, 0.0),
#                                `Maintenance Material` = c(0.0, 0.0),
#                                `Maintenance Plant` = c(0.0, 0.0),
#                                `Customer Use (Road Vehicle Use)` = c(0.0, 0.0),
#                                `Train Operation` = c(0.0, 0.0),
#                                `Decommissioning Emissions` = c(0.0, 0.0),
#                                `Decommissioning Waste Disposal` = c(0.0, 0.0),
#                                `Decommissioning Waste Transport` = c(0.0, 0.0),
#                                `Total` = c(0.0, 0.0),
#                                stringsAsFactors = F, check.names = FALSE)
DF_emis_detailed_rail <- data.table(Option = c(1:10),
                               Name = c("",""),
                               `Raw Material Supply and Manufacture (A1, A3)` = c(0.0, 0.0),
                               `Raw Material Transport (A2)` = c(0.0, 0.0),
                               `Construction Worker Travel to Site (A4)` = c(0.0, 0.0),
                               `Clearance and demolition (A5)` = c(0.0, 0.0),
                               `Land Use Change and Vegetation Loss (A5)` = c(0.0, 0.0),
                               `Clearance and Demolition Water Use (A5)` = c(0.0, 0.0),
                               `Excavation (A5)` = c(0.0, 0.0),
                               `Plant Use (A5)` = c(0.0, 0.0),
                               `Construction Water Use (A5)` = c(0.0, 0.0),
                               `Construction Waste Disposal (A5)` = c(0.0, 0.0),
                               `Construction Waste Transport (A5)` = c(0.0, 0.0),
                               `Landscaping and Vegetation (A5)` = c(0.0, 0.0),
                               `Operational Waste Disposal (B1)` = c(0.0, 0.0),
                               `Operational Waste Transport (B1)` = c(0.0, 0.0),
                               `Maintenance (B2-B5)` = c(0.0, 0.0),
                               `Maintenance Plant (B2-B5)` = c(0.0, 0.0),
                               `Operational Energy Use (B6)` = c(0.0, 0.0),
                               `Operational Water Use (B7)` = c(0.0, 0.0),
                               `Users Utilisation of Infrastructure (B8)` = c(0.0, 0.0),
                               `Train Operation (B8)` = c(0.0, 0.0),
                               `Decommissioning Emissions (C1)` = c(0.0, 0.0),
                               `Decommissioning Waste Transport (C2)` = c(0.0, 0.0),
                               `Decommissioning Waste Disposal (C3-C4)` = c(0.0, 0.0),
                               `Total` = c(0.0, 0.0),
                               stringsAsFactors = F, check.names = FALSE)


# tblheader_DF_emis_detailed_rail <- htmltools::withTags(table(
#   class = 'display',
#   thead(
#     tr(
#       th(rowspan = 2, 'Option'), #rowspan = 2, 'Option',
#       th(rowspan = 2, 'Name'), #rowspan = 2, 'Name',
#       th(colspan = 2, 'Embodied Carbon'),
#       th(colspan = 7, 'Construction Activities'),
#       th(colspan = 2, 'Construction Waste'),
#       th(colspan = 5, 'Light Rail Use'),
#       th(colspan = 2, 'Maintenance'),
#       th(colspan = 2, 'User Emissions'),
#       th(colspan = 3, 'End of Life'),
#       th(rowspan = 2, 'Total')
#     ),
#     tr(
#       lapply(names(DF_emis_detailed_rail)[3:25], th)
#     )
#   )
# ))
tblheader_DF_emis_detailed_rail <- htmltools::withTags(table(
  class = 'display',
  thead(
    tr(
      th(rowspan = 2, 'Option'), #rowspan = 2, 'Option',
      th(rowspan = 2, 'Name'), #rowspan = 2, 'Name',
      th(colspan = 2, 'Product Stage (A1-A3)'),
      th(colspan = 10, 'Construction Process Stage (A4-A5)'),
      #th(colspan = 2, 'Construction Waste'),
      th(colspan = 6, 'Operational Use (B1-B7)'),
      #th(colspan = 2, 'Maintenance'),
      th(colspan = 2, 'User Emissions (B8)'),
      th(colspan = 3, 'End of Life (C1-C4)'),
      th(rowspan = 2, 'Total')
    ),
    tr(
      lapply(names(DF_emis_detailed_rail)[3:25], th)
    )
  )
))


# DF_detailed_lookup <- data.table(Stage = c("Pre-Construction","Pre-Construction","Pre-Construction",
#                                            "Embodied Carbon","Embodied Carbon",
#                                            "Construction","Construction","Construction","Construction","Construction","Construction",
#                                            "Operational Use","Operational Use","Operational Use","Operational Use","Operational Use","Embodied Carbon","Maintenance","User Emissions",
#                                            "End of Life", "End of Life", "End of Life"),
#                                  Measure = c("Clearance & Demolition Activities","Land Use Change & Vegetation Loss","Water Use",
#                                              "Embodied","Transport",
#                                              "Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site","Construction Waste Disposal","Construction Waste Transport",
#                                              "Energy Use","Water Use","Operational Waste Disposal","Operational Waste Transport","Landscaping and Vegetation","Maintenance","Maintenance Plant Fuel Use","Vehicle Use",
#                                              "Activity", "Waste Processing", "Transport"),
#                                  Detailed = c("Clearance and demolition","Land Use Change and Vegetation Loss","Clearance and Demolition Water Use",
#                                               "Materials","Material Transport",
#                                               "Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site","Construction Waste Disposal","Construction Waste Transport",
#                                               "Operational Energy","Operational Water","Operational Waste Disposal","Operational Waste Transport","Landscaping and Vegetation","Maintenance Material","Maintenance Plant","Customer Use (Road Vehicle Use)",
#                                               "Decommissioning Emissions", "Decommissioning Waste Disposal", "Decommissioning Waste Transport"),
#                                  stringsAsFactors = F, check.names = FALSE)
DF_detailed_lookup <- data.table(Stage = c("Pre-Construction","Pre-Construction","Pre-Construction",
                                           "Embodied Carbon","Embodied Carbon",
                                           "Construction","Construction","Construction","Construction","Construction","Construction",
                                           "Operational Use","Operational Use","Operational Use","Operational Use","Operational Use","Embodied Carbon","Maintenance","User Emissions",
                                           "End of Life", "End of Life", "End of Life"),
                                 Measure = c("Clearance & Demolition Activities","Land Use Change & Vegetation Loss","Water Use",
                                             "Embodied","Transport",
                                             "Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site","Construction Waste Disposal","Construction Waste Transport",
                                             "Energy Use","Water Use","Operational Waste Disposal","Operational Waste Transport","Landscaping and Vegetation","Maintenance","Maintenance Plant Fuel Use","Vehicle Use",
                                             "Activity", "Waste Processing", "Transport"),
                                 Detailed = c("Clearance and demolition (A5)","Land Use Change and Vegetation Loss (A5)","Clearance and Demolition Water Use (A5)",
                                              "Raw Material Supply and Manufacture (A1, A3)","Raw Material Transport (A2)",
                                              "Excavation (A5)","Construction Water Use (A5)","Plant Use (A5)","Construction Worker Travel to Site (A4)","Construction Waste Disposal (A5)","Construction Waste Transport (A5)",
                                              "Operational Energy Use (B6)","Operational Water Use (B7)","Operational Waste Disposal (B1)","Operational Waste Transport (B1)","Landscaping and Vegetation (A5)","Maintenance (B2-B5)","Maintenance Plant (B2-B5)","Users Utilisation of Infrastructure (B8)",
                                              "Decommissioning Emissions (C1)", "Decommissioning Waste Disposal (C3-C4)", "Decommissioning Waste Transport (C2)"),
                                 stringsAsFactors = F, check.names = FALSE)


DF_new_detailed_lookup <- data.table(Detailed = c('Raw Material Supply and Manufacture (A1, A3)',
                                                  'Raw Material Transport (A2)',
                                                  'Construction Worker Travel to Site (A4)',
                                                  'Clearance and demolition (A5)',
                                                  'Land Use Change and Vegetation Loss (A5)',
                                                  'Clearance and Demolition Water Use (A5)',
                                                  'Excavation (A5)',
                                                  'Plant Use (A5)',
                                                  'Construction Water Use (A5)',
                                                  'Construction Waste Disposal (A5)',
                                                  'Construction Waste Transport (A5)',
                                                  'Landscaping and Vegetation (A5)',
                                                  'Operational Waste Disposal (B1)',
                                                  'Operational Waste Transport (B1)',
                                                  'Maintenance (B2-B5)',
                                                  'Maintenance Plant (B2-B5)',
                                                  'Operational Energy Use (B6)',
                                                  'Operational Water Use (B7)',
                                                  'Users Utilisation of Infrastructure (B8)',
                                                  'Decommissioning Emissions (C1)',
                                                  'Decommissioning Waste Transport (C2)',
                                                  'Decommissioning Waste Disposal (C3-C4)'),
                                     Stage = c('Product Stage (A1-A3)',
                                               'Product Stage (A1-A3)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Construction Process Stage (A4-5)',
                                               'Operational Use (B1-B7)',
                                               'Operational Use (B1-B7)',
                                               'Operational Use (B1-B7)',
                                               'Operational Use (B1-B7)',
                                               'Operational Use (B1-B7)',
                                               'Operational Use (B1-B7)',
                                               'User Emissions (B8)',
                                               'End of Life (C1-C4)',
                                               'End of Life (C1-C4)',
                                               'End of Life (C1-C4)'), stringsAsFactors = F, check.names = FALSE
)


DF_detailed_lookup_rail <- data.table(Stage = c("Pre-Construction","Pre-Construction","Pre-Construction",
                                                "Embodied Carbon","Embodied Carbon",
                                                "Construction","Construction","Construction","Construction","Construction","Construction",
                                                "Operational Use","Operational Use","Operational Use","Operational Use","Operational Use","Embodied Carbon","Maintenance","User Emissions","User Emissions",
                                                "End of Life", "End of Life", "End of Life"),
                                      Measure = c("Clearance & Demolition Activities","Land Use Change & Vegetation Loss","Water Use",
                                                  "Embodied","Transport",
                                                  "Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site","Construction Waste Disposal","Construction Waste Transport",
                                                  "Energy Use","Water Use","Operational Waste Disposal","Operational Waste Transport","Landscaping and Vegetation","Maintenance","Maintenance Plant Fuel Use","Vehicle Use","Train Operation",
                                                  "Activity", "Waste Processing", "Transport"),
                                      Detailed = c("Clearance and demolition (A5)","Land Use Change and Vegetation Loss (A5)","Clearance and Demolition Water Use (A5)",
                                                   "Raw Material Supply and Manufacture (A1, A3)","Raw Material Transport (A2)",
                                                   "Excavation (A5)","Construction Water Use (A5)","Plant Use (A5)","Construction Worker Travel to Site (A4)","Construction Waste Disposal (A5)","Construction Waste Transport (A5)",
                                                   "Operational Energy Use (B6)","Operational Water Use (B7)","Operational Waste Disposal (B1)","Operational Waste Transport (B1)","Landscaping and Vegetation (A5)","Maintenance (B2-B5)","Maintenance Plant (B2-B5)","Users Utilisation of Infrastructure (B8)","Train Operation (B8)",
                                                   "Decommissioning Emissions (C1)", "Decommissioning Waste Disposal (C3-C4)", "Decommissioning Waste Transport (C2)"),
                                      stringsAsFactors = F, check.names = FALSE)

DF_new_detailed_lookup_rail <- data.table(Detailed = c('Raw Material Supply and Manufacture (A1, A3)',
                                                       'Raw Material Transport (A2)',
                                                       'Construction Worker Travel to Site (A4)',
                                                       'Clearance and demolition (A5)',
                                                       'Land Use Change and Vegetation Loss (A5)',
                                                       'Clearance and Demolition Water Use (A5)',
                                                       'Excavation (A5)',
                                                       'Plant Use (A5)',
                                                       'Construction Water Use (A5)',
                                                       'Construction Waste Disposal (A5)',
                                                       'Construction Waste Transport (A5)',
                                                       'Landscaping and Vegetation (A5)',
                                                       'Operational Waste Disposal (B1)',
                                                       'Operational Waste Transport (B1)',
                                                       'Maintenance (B2-B5)',
                                                       'Maintenance Plant (B2-B5)',
                                                       'Operational Energy Use (B6)',
                                                       'Operational Water Use (B7)',
                                                       'Users Utilisation of Infrastructure (B8)',
                                                       'Train Operation (B8)',
                                                       'Decommissioning Emissions (C1)',
                                                       'Decommissioning Waste Transport (C2)',
                                                       'Decommissioning Waste Disposal (C3-C4)'),
                                             Stage = c('Product Stage (A1-A3)',
                                                       'Product Stage (A1-A3)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Construction Process Stage (A4-5)',
                                                       'Operational Use (B1-B7)',
                                                       'Operational Use (B1-B7)',
                                                       'Operational Use (B1-B7)',
                                                       'Operational Use (B1-B7)',
                                                       'Operational Use (B1-B7)',
                                                       'Operational Use (B1-B7)',
                                                       'User Emissions (B8)',
                                                       'User Emissions (B8)',
                                                       'End of Life (C1-C4)',
                                                       'End of Life (C1-C4)',
                                                       'End of Life (C1-C4)'), stringsAsFactors = F, check.names = FALSE
)

# DF_emis_embcarbon <- data.table(Option = c(1:10),
#                                 Name = c("",""),
#                                 `Series 300 - Fencing and Environmental Noise Barriers` = c(0.0, 0.0),
#                                 `Series 400 - Road Restraint System` = c(0.0, 0.0),
#                                 `Series 500 - Drainage and surface ducts` = c(0.0, 0.0),
#                                 `Series 600 - Earthworks` = c(0.0, 0.0),
#                                 `Series 800 - Road Pavements - Unbound and Cement Bound Mixtures` = c(0.0, 0.0),
#                                 `Series 900 - Road Pavements - Bituminous Materials` = c(0.0, 0.0),
#                                 `Series 1000 - Road Pavements - Concrete Materials` = c(0.0, 0.0),
#                                 `Series 1100 - Kerbs, Footways and Paved Areas` = c(0.0, 0.0),
#                                 `Series 1200 - Traffic Signs and Road Markings` = c(0.0, 0.0),
#                                 `Series 1500 - Traffic Control and Communications` = c(0.0, 0.0),
#                                 `Series 1600 - Piling and Embedded Retaining Walls` = c(0.0, 0.0),
#                                 `Series 1700 - Structural Concrete` = c(0.0, 0.0),
#                                 `Series 1800 - Structural Steelwork` = c(0.0, 0.0),
#                                 `Series 2400 - Brickwork, Blockwork and Stonework` = c(0.0, 0.0),
#                                 `Other-Street Furniture and Electrical Equipment` = c(0.0, 0.0),
#                                 `Other-Timber` = c(0.0, 0.0),
#                                 `Other-Tunnels` = c(0.0, 0.0),
#                                 stringsAsFactors = F, check.names = FALSE)
# 
# DF_emis_embcarbon_rail <- data.table(Option = c(1:10),
#                                 Name = c("",""),
#                                 `Series 300 - Fencing and Environmental Noise Barriers` = c(0.0, 0.0),
#                                 `Series 400 - Road Restraint System` = c(0.0, 0.0),
#                                 `Series 500 - Drainage and surface ducts` = c(0.0, 0.0),
#                                 `Series 600 - Earthworks` = c(0.0,0.0),
#                                 `Series 1200 - Traffic Signs and Road Markings` = c(0.0, 0.0),
#                                 `Series 1500 - Traffic Control and Communications` = c(0.0, 0.0),
#                                 `Series 1600 - Piling and Embedded Retaining Walls` = c(0.0,0.0),
#                                 `Series 1700 - Structural Concrete` = c(0.0,0.0),
#                                 `Series 1800 - Structural Steelwork` = c(0.0,0.0),
#                                 `Series 2400 - Brickwork, Blockwork and Stonework` = c(0.0,0.0),
#                                 `Railtrack` = c(0.0,0.0),
#                                 `Other-Street Furniture and Electrical Equipment` = c(0.0,0.0),
#                                 `Other-Timber` = c(0.0,0.0),
#                                 `Other-Tunnels` = c(0.0,0.0),
#                                 stringsAsFactors = F, check.names = FALSE)

# new emission factors update (May 2025) category lists for road and rail
DF_emis_embcarbon <- data.table(Option = c(1:10),
                                Name = c("",""),
                                `Series number: 300 - Fencing and Environmental Noise Barriers` = c(0.0, 0.0),
                                `Series number: 400 - Safety Barrier Systems` = c(0.0, 0.0),
                                `Series number: 500 - Drains, Sewers, Piped Culverts and Service Ducts` = c(0.0, 0.0),
                                `Series number: 600 - Earthworks` = c(0.0, 0.0),
                                `Series number: 700 - Pavements` = c(0.0, 0.0),
                                `Series number: 1100 - Kerbs, Footways and Paved Areas` = c(0.0, 0.0),
                                `Series number: 1200 - Traffic Signs and Road Markings` = c(0.0, 0.0),
                                `Series number: 1300 - Road Lighting Columns and Brackets` = c(0.0, 0.0),
                                `Series number: 1400 - Electrical Work for Road Lighting and Traffic Signs` = c(0.0, 0.0),
                                `Series number: 1700 - Structural Concrete` = c(0.0, 0.0),
                                `Series number: 2000 - Waterproofing for structures` = c(0.0, 0.0),
                                `Series number: 2100 - Bearings` = c(0.0, 0.0),
                                `Series number: 2300 - Bridge Expansion Joints and Sealing of Gaps` = c(0.0, 0.0),
                                `Series number: 2400 - Brickwork, Blockwork and Stonework` = c(0.0, 0.0),
                                `Series number: 2700 - Watermains, Utilities and Accommodation Works` = c(0.0, 0.0),
                                `Other` = c(0.0, 0.0),
                                stringsAsFactors = F, check.names = FALSE)

DF_emis_embcarbon_rail <- data.table(Option = c(1:10),
                                     Name = c("",""),
                                     `Series number: 300 - Fencing and Environmental Noise Barriers` = c(0.0, 0.0),
                                     `Series number: 400 - Safety Barrier Systems` = c(0.0, 0.0),
                                     `Series number: 500 - Drains, Sewers, Piped Culverts and Service Ducts` = c(0.0, 0.0),
                                     `Series number: 600 - Earthworks` = c(0.0, 0.0),
                                     `Series number: 2000 - Waterproofing for structures` = c(0.0, 0.0),
                                     `Series number: 2100 - Bearings` = c(0.0, 0.0),
                                     `Series number: 2300 - Bridge Expansion Joints and Sealing of Gaps` = c(0.0, 0.0),
                                     `Series number: 2700 - Watermains, Utilities and Accommodation Works` = c(0.0, 0.0),
                                     `Series number: 1200 - Traffic Signs and Road Markings` = c(0.0, 0.0),
                                     `Series number: 1400 - Electrical Work for Road Lighting and Traffic Signs` = c(0.0, 0.0),
                                     `Series number: 1700 - Structural Concrete` = c(0.0, 0.0),
                                     `Series number: 2000 - Waterproofing for structures` = c(0.0, 0.0),
                                     `Series number: 2100 - Bearings` = c(0.0, 0.0),
                                     `Series number: 2300 - Bridge Expansion Joints and Sealing of Gaps` = c(0.0, 0.0),
                                     `Series number: 2700 - Watermains, Utilities and Accommodation Works` = c(0.0, 0.0),
                                     `Railtrack` = c(0.0, 0.0),
                                     `Other` = c(0.0, 0.0),
                                     stringsAsFactors = F, check.names = FALSE)


DF_emis_intensity <- data.table(Option = c(1:10),
                                Name = c("",""),
                                `tCO2e per km of road` = c(0.0, 0.0),
                                `tCO2e per Euro spent` = c(0.0, 0.0),
                                stringsAsFactors = F, check.names = FALSE)


####

#area_units <- c("ha", "m2","km2","mi2") # define area units for dropdowns
# generate conversion factors from hectare (default) to other area units
#area_conversion <- data.table(area_units)[, V2 := c(1,0.0001,100,258.9989174)]
#names(area_conversion) <- c("unit","conv_factor")

area_conversion <- data.table(`unit` = c("ha", "m2", "km2", "mi2"),
                              `conv_factor` = c(1,0.0001,100,258.9989174),
                              stringsAsFactors = F, check.names = FALSE)

water_conversion <- data.table(`unit` = c("litres", "m3", "gallon"),
                               `conv_factor` = c(1,1000,4.546092),
                               stringsAsFactors = F, check.names = FALSE) 
kgConversion <- 0.001  # This represents a conversion from kg to Tonnes as requested by EG 03/12/2021


## SIZE OF PROJECT OPTIONS #################################################
projectSizeDefaults <- efs$Size


## Pre-Construction Sub-Module ####################################
preconst_cada_activity_dropdown <- as.character(efs$Activity_Road[Category == "Demolition and Site Clearance", "Activity"]$Activity)
preconst_lucavl_activity_dropdown <- as.character(efs$Carbon[Column2 == "Carbon Sequestration", "Carbon Sink"]$`Carbon Sink`)
##

## CONSTRUCTION MODULE ############################################

### Excavation activities table ###################################
excavTbl_dropdown_opts_road <- efs$Activity_Road %>%
  filter(Category %in% "Earthworks - Excavation") %>%
  as.data.table()

# same opts for road and rail at present
#excavTbl_dropdown_opts_rail <- excavTbl_dropdown_opts_road
excavTbl_dropdown_opts_rail <- efs$Activity_Rail %>%
  filter(Category %like% "Earthworks") %>%
  as.data.table()


### Construction Activities table #################################
# take construction activities list and left-join with fuels
constrTbl_dropdown_opts_road <- efs$Construction_Activities %>% 
  left_join(y = fuels, by = c(`Energy Type` = "Fuel")) %>% 
  as.data.table()

constrTbl_dropdown_opts_rail <- constrTbl_dropdown_opts_road

### Water Use During Construction table #################################
# cross join of Activity Type with Water Use EFs
# water use EFs are identical regardless of chosen activity type
wuconstrTbl_dropdown_opts_road <-
  data.table(`Activity Type` = c("Construction", "Demolition and Clearance","Earthworks")) %>%
  cross_join(y = water_use) %>%
  as.data.table()
# AT comment: Rail does not include a Construction type option - have added here but need to verify if correct
wuconstrTbl_dropdown_opts_rail <-
  data.table(`Activity Type` = c("Construction", "Demolition and Clearance","Earthworks")) %>%
  cross_join(y = water_use) %>%
  as.data.table()

### Workforce Transport Table ##############################################
worktravelconstrTbl_dropdown_opts_road <- efs$Vehicle %>%
  filter(Category %in% "Passenger Vehicles") %>%
  as.data.table()

worktravelconstrTbl_dropdown_opts_rail <- worktravelconstrTbl_dropdown_opts_road

### Landscaping & Vegetation Table #############################################
landvegconstrTbl_dropdown_opts_road <- efs$Carbon %>%
  filter(Column3 %in% "Land use change - untouched") %>%
  as.data.table()

landvegconstrTbl_dropdown_opts_rail <- landvegconstrTbl_dropdown_opts_road


## WASTE MODULE ########################################################

wasteTbl_dropdown_opts_road <- efs$Waste %>%
  select(`Waste Type`, `Waste Route`,`Unit`,`kgCO2e per unit`) %>%
  as.data.table()

# same opts for road and rail at present
wasteTbl_dropdown_opts_rail <- wasteTbl_dropdown_opts_road

transmodewasteTbl_dropdown_opts_road <- efs$Vehicle %>%
  filter(Category %in% "Freight Vehicles") %>%
  as.data.table()

transmodewasteTbl_dropdown_opts_rail <- transmodewasteTbl_dropdown_opts_road


## USE SUBMODULE #############################################################
use_oeu_en_use_cat_dropdown <- as.character(c("Lighting","Signs","Office Facilities","Other"))
use_oeu_energytype_dropdown <- as.character(efs$Fuel$Fuel)


# initialise dummy data table to combine submodule outputs from each stage
DF_road_summary_data <- data.table(Option = c("Road 1", "Road 1", "Road 1", "Road 1",
                                              "Road 1", "Road 1", "Road 1", "Road 1",
                                              "Road 1", "Road 1", "Road 1", "Road 1", "Road 1", "Road 1",
                                              "Road 1", "Road 1", "Road 1", "Road 1", "Road 1",
                                              "Road 1", "Road 1", "Road 1", "Road 1",
                                              "Road 2", "Road 2", "Road 2", "Road 2",
                                              "Road 2", "Road 2", "Road 2", "Road 2",
                                              "Road 2", "Road 2", "Road 2", "Road 2", "Road 2", "Road 2",
                                              "Road 2", "Road 2", "Road 2", "Road 2", "Road 2",
                                              "Road 2", "Road 2", "Road 2", "Road 2"),
                                   Stage = c("Pre-Construction","Pre-Construction","Pre-Construction","Pre-Construction",
                                             "Embodied Carbon","Embodied Carbon","Embodied Carbon","Embodied Carbon",
                                             "Construction","Construction","Construction","Construction","Construction","Construction",
                                             "Use","Use","Use","Use","Use",
                                             "End of Life","End of Life","End of Life", "End of Life",
                                             "Pre-Construction","Pre-Construction","Pre-Construction","Pre-Construction",
                                             "Embodied Carbon","Embodied Carbon","Embodied Carbon","Embodied Carbon",
                                             "Construction","Construction","Construction","Construction","Construction","Construction",
                                             "Use","Use","Use","Use","Use",
                                             "End of Life","End of Life","End of Life", "End of Life"),
                                   Measure = c("Clearance & Demolition Activities","Land Use Change & Vegetation Loss","Water Use","Total",
                                               "Embodied","Maintenance","Transport","Total",
                                               "Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site","Landscaping and Vegetation","Total",
                                               "Energy Use","Water Use","Maintenance Plant Fuel Use","Vehicle Use","Total",
                                               "Activity","Waste Processing","Transport","Total",
                                               "Clearance & Demolition Activities","Land Use Change & Vegetation Loss","Water Use","Total",
                                               "Embodied","Maintenance","Transport","Total",
                                               "Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site","Landscaping and Vegetation","Total",
                                               "Energy Use","Water Use","Maintenance Plant Fuel Use","Vehicle Use","Total",
                                               "Activity","Waste Processing","Transport","Total"),
                                   Value = c(0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0,0.0,
                                             0.0,0.0,0.0,0.0),
                                   stringsAsFactors = F, check.names = FALSE)
## LOAD/SAVE #############################################################

# collate shiny input ids
collatedShinyInputs <- NULL

projInputs <- c("Opts-Proj1-projRef", "Opts-Proj1-nameUser", "Opts-Proj1-nameCompany", "Opts-Proj1-namecontractors", "Opts-Proj1-nameProj",
                "Opts-Proj1-projValue", "Opts-Proj1-projPhase", "Opts-Proj1-lifeTime", "Opts-Proj1-projDesc", "Opts-Proj1-dateProj",
                "Opts-Proj1-dateStart", "Opts-Proj1-dateEnd")
projInputs2 <- c("projRef", "nameUser", "nameCompany", "namecontractors", "nameProj",
                 "projValue", "projPhase", "lifeTime", "projDesc", "dateProj",
                 "dateStart", "dateEnd")
projMod <- "Proj1"
collatedShinyInputs <- rbind(collatedShinyInputs,data.frame(inputId = projInputs, Opts = "Opts", Module = projMod, idInput = projInputs2))

appInputs <- c("NumRoadOpts", "NumRailOpts", "NumGreenwayOpts")
appMod <- "app"
collatedShinyInputs <- rbind(collatedShinyInputs, data.frame(inputId = appInputs, Opts = "Opts", Module = appMod, idInput = appInputs))

#RoadHomeInputs <- c("Phase")
#RoadHomeMod <- "RoadHome"
#collatedShinyInputs <- rbind(collatedShinyInputs, data.frame(inputId =  paste0("Opts-", RoadHomeMod,"-", RoadHomeInputs), Opts = "Opts", Module = RoadHomeMod, idInput = RoadHomeInputs))

#RailHomeInputs <- c("Phase")
#RailHomeMod <- "RailHome"
#collatedShinyInputs <- rbind(collatedShinyInputs, data.frame(inputId =  paste0("Opts-", RailHomeMod,"-", RailHomeInputs), Opts = "Opts", Module = RailHomeMod, idInput = RailHomeInputs))


#scopingInputs <- c("GHGrep", "MatTransp", "MatTranspRatnl", "embGHGem", "embGHGemRatnl",
#                   "constplantEmis", "maintplantEmis", "HighLevelInfo")

scopingInputs <- c('preconCadaEmis', 'preconCadaEmisRatnl', 'preconLucavlEmis', 'preconLucavlEmisRatnl', 'preconWudcdaEmis', 'preconWudcdaEmisRatnl',
                   'MatTransp',  'MatTranspRatnl',  'embGHGem',  'embGHGemRatnl',  'GHGrep',
                   'GHGrepRatnl',  'clearanceEmis',  'clearanceEmisRatnl',  'excavationEmis',  'excavationEmisRatnl',
                   'constplantEmis',  'constplantEmisRatnl',  'constwaterEmis',  'constwaterEmisRatnl',  'constwasteEmis',
                   'constwasteEmisRatnl',  'operationEmis',  'operationEmisRatnl',  'operwaterEmis',  'operwaterEmisRatnl',
                   'operwasteEmis',  'operwasteEmisRatnl',  'maintplantEmis',  'maintplantEmisRatnl',  'MatDisposal',
                   'MatDisposalRatnl',  'decomPlant',  'decomPlantRatnl')


scopingMod <- "Scoping1"
collatedShinyInputs <- rbind(collatedShinyInputs, data.frame(inputId = paste0("Opts-",scopingMod,"-",scopingInputs), Opts = "Opts", Module = scopingMod, idInput = scopingInputs))

baselineInputs <- c("schemeType", "existingLandCondition", "baseline_aadt" ,"baseline_addt_chg", "baseline_aadt_chg_percent")
baselineMod <- sort(c(paste0("baselinero", rep(1:total_num_options,length(baselineInputs))), paste0("baselinera", rep(1:total_num_options,length(baselineInputs))), paste0("baselinegw", rep(1:total_num_options,length(baselineInputs)))))
collatedShinyInputs <- rbind(collatedShinyInputs, data.frame(inputId = paste0("Opts-",baselineMod,"-",baselineInputs), Opts = "Opts", Module = baselineMod, idInput =  baselineInputs))

constInputs <- c("constrwasteToggle","constCost")
constMod <- sort(c(paste0("constro", rep(1:total_num_options,length(constInputs))), paste0("constra", rep(1:total_num_options,length(constInputs))), paste0("constgw", rep(1:total_num_options,length(constInputs)))))
collatedShinyInputs <- rbind(collatedShinyInputs, data.frame(inputId = paste0("Opts-",constMod,"-",constInputs), Opts = "Opts", Module = constMod, idInput =  constInputs))


collatedShinyInputs$Value <- "Empty"


# collate list of table input ids and save file ids
RoadHomeInputs <- c("prevDataTbl", "highLevelTbl")
RoadHomeTableLoadFiles <- data.frame(filename = paste0("RoadHome", "_",RoadHomeInputs), input = paste0("Opts-","RoadHome-",RoadHomeInputs), 
                                     server = "RoadHome_serv", obj = paste0(RoadHomeInputs,"Resave"))

RailHomeInputs <- c("prevDataTbl", "highLevelTbl")
RailHomeTableLoadFiles <- data.frame(filename = paste0("RailHome", "_",RailHomeInputs), input = paste0("Opts-","RailHome-",RailHomeInputs),
                                     server = "RailHome_serv", obj = paste0(RailHomeInputs,"Resave"))

GreenwayHomeInputs <- c("prevDataTbl", "highLevelTbl")
GreenwayHomeTableLoadFiles <- data.frame(filename = paste0("GreenwayHome", "_",GreenwayHomeInputs), input = paste0("Opts-","GreenwayHome-",GreenwayHomeInputs), 
                                     server = "GreenwayHome_serv", obj = paste0(GreenwayHomeInputs,"Resave"))
									 
preconstInputs <- c("cadaTbl", "lucavlTbl", "wudcdaTbl" ,"csavoNoImplTbl", "csavoImplTbl")
preconstMod <- sort(c(paste0("preconstro", rep(1:total_num_options,length(preconstInputs))), paste0("preconstra", rep(1:total_num_options,length(preconstInputs))), paste0("preconstgw", rep(1:total_num_options,length(preconstInputs)))))
preconstTableLoadFiles <- data.frame(filename = paste0(preconstMod, "_",preconstInputs), input = paste0("Opts-",preconstMod,"-",preconstInputs),
                                     server = paste0(preconstMod,"_serv"), obj = paste0(preconstInputs,"Resave"))

embcarbonInputs <- c("rmecTbl", "transTbl", "csavoNoImplTbl", "csavoImplTbl") # 
embcarbonMod <- sort(c(paste0("embcarbonro", rep(1:total_num_options,length(embcarbonInputs))), paste0("embcarbonra", rep(1:total_num_options,length(embcarbonInputs))), paste0("embcarbongw", rep(1:total_num_options,length(embcarbonInputs)))))
embcarbonTableLoadFiles <-  data.frame(filename = paste0(embcarbonMod, "_",embcarbonInputs), input = paste0("Opts-",embcarbonMod,"-",embcarbonInputs),
                                       server = paste0(embcarbonMod,"_serv"), obj = paste0(embcarbonInputs,"Resave"))

constInputs <- c("excavTbl", "constrTbl", "constrTblAlt", "wuconstrTbl" , "constrProjSizeTbl", "worktravelconstrTbl", "constrwasteTbl", "csavoNoImplTbl", "csavoImplTbl") # , "landvegconstrTbl"
constMod <- sort(c(paste0("constro", rep(1:total_num_options,length(constInputs))), paste0("constra", rep(1:total_num_options,length(constInputs))), paste0("constgw", rep(1:total_num_options,length(constInputs)))))
constTableLoadFiles <- data.frame(filename = paste0(constMod, "_",constInputs), input = paste0("Opts-",constMod,"-",constInputs),
                                  server = paste0(constMod,"_serv"), obj = paste0(constInputs,"Resave"))

useInputs <- c("oeuTbl", "owuTbl", "operwasteTbl", "landvegconstrTbl", "csavoNoImplTbl", "csavoImplTbl")  #  "mpfuTbl", "vehuTbl" 
useMod <- sort(c(paste0("usero", rep(1:total_num_options,length(useInputs))), paste0("usera", rep(1:total_num_options,length(useInputs))), paste0("usegw", rep(1:total_num_options,length(useInputs)))))
useTableLoadFiles <- data.frame(filename = paste0(useMod, "_",useInputs), input = paste0("Opts-",useMod,"-",useInputs),
                                server = paste0(useMod,"_serv"), obj = paste0(useInputs,"Resave"))

useremisInputs <- c("vehuTbl", "csavoNoImplTbl", "csavoImplTbl")
useremisMod <- sort(c(paste0("useremisro", rep(1:total_num_options,length(useremisInputs))), paste0("useremisgw", rep(1:total_num_options,length(useremisInputs)))))
useremisTableLoadFiles <- data.frame(filename = paste0(useremisMod, "_",useremisInputs), input = paste0("Opts-",useremisMod,"-",useremisInputs),
                                server = paste0(useremisMod,"_serv"), obj = paste0(useremisInputs,"Resave"))

useremisrailInputs <- c("vehuTbl", "trainTbl", "csavoNoImplTbl", "csavoImplTbl")
useremisrailMod <- sort(paste0("useremisra", rep(1:total_num_options,length(useremisrailInputs))))
useremisrailTableLoadFiles <- data.frame(filename = paste0(useremisrailMod, "_",useremisrailInputs), input = paste0("Opts-",useremisrailMod,"-",useremisrailInputs),
                                     server = paste0(useremisrailMod,"_serv"), obj = paste0(useremisrailInputs,"Resave"))


maintInputs <- c("mpfuTbl", "csavoNoImplTbl", "csavoImplTbl")
maintMod <- sort(c(paste0("maintro", rep(1:total_num_options,length(maintInputs))), paste0("maintra", rep(1:total_num_options,length(maintInputs))), paste0("maintgw", rep(1:total_num_options,length(maintInputs)))))
maintTableLoadFiles <- data.frame(filename = paste0(maintMod, "_",maintInputs), input = paste0("Opts-",maintMod,"-",maintInputs),
                                server = paste0(maintMod,"_serv"), obj = paste0(maintInputs,"Resave"))

eolifeInputs <- c("deconTbl", "wasManTbl", "csavoNoImplTbl", "csavoImplTbl")
eolifeMod <- sort(c(paste0("eolifero", rep(1:total_num_options,length(eolifeInputs))), paste0("eolifera", rep(1:total_num_options,length(eolifeInputs))),paste0("eolifegw", rep(1:total_num_options,length(eolifeInputs)))))
eolifeTableLoadFiles <- data.frame(filename = paste0(eolifeMod, "_",eolifeInputs), input = paste0("Opts-",eolifeMod,"-",eolifeInputs),
                                   server = paste0(eolifeMod,"_serv"), obj = paste0(eolifeInputs,"Resave"))

collatedTableLoadFiles <- rbind(RoadHomeTableLoadFiles, RailHomeTableLoadFiles, GreenwayHomeTableLoadFiles, preconstTableLoadFiles, embcarbonTableLoadFiles, 
                                constTableLoadFiles, useTableLoadFiles, useremisTableLoadFiles, useremisrailTableLoadFiles, maintTableLoadFiles, eolifeTableLoadFiles)




# ## rewrite temp save files
# for (i in 1:nrow(collatedTableLoadFiles)){
#   file.remove(paste0("Temp/",collatedTableLoadFiles[i,1],".csv"))
# }
# 
# # for (i in 1:length(fileNames)){
# for (i in 1:nrow(collatedTableLoadFiles)){
#   write.csv("Nothing to see here",paste0("Temp/",collatedTableLoadFiles[i,1],".csv"), row.names = F)
# }
# 
# inputs_data_frame_initial <- read.csv("Temp/inputs_data_frame.csv", header = T)
# inputs_data_frame_initial$Value <- "Empty"
# write.csv(inputs_data_frame_initial, "Temp/inputs_data_frame.csv", row.names = F)

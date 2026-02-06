##### Construction submodule ##################################################################################################################

# Last modified by Andy Brown (11/01/2022)
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory

###############################################################################################################################################

const_ui <- function(id,tabName){
  ns <- NS(id)

    tabItem(
    tabName = tabName,
    fluidRow(
    box(width = 12,
        
        fluidRow(
          column(width = 7,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), constr_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 5, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 h6(HTML("<br>")),
                 h4(tagList(eflibrary_icon, " Total Construction Emissions (tCO2e):  ", textOutput(outputId = ns("sum_totalconst_waste_tCO2"), inline = T),
                            HTML("&nbsp;"), HTML("&nbsp;")))
          )
        ),
        
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            hidden(
                              div(id = ns("guid_notes"),
                                  p(HTML("<br> </br>The <b>Before Use - Construction Stage</b> considers construction activities that will take place during infrastructure development, including excavation activities, energy use of construction activities, water use, and landscaping and vegetation. <br><br>
                          Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                          The data input tables require:<br>
                          <ul><li>Details on the excavation activities required</li>
                          
                          <li>The fuel use for each site activity undertaken. There are two tables provided for the user to avail of depending on the nature 
                          of the data available to them. The first calculates CO2e based on fuel use per hour for a specified number of days, the second 
                          calculates CO2e based on total fuel use throughout the construction phase. These tables can be used in combination 
                          with each other or separately, as required</li>
                          
                          <li>The water use during construction</li>
                          <li>Details of construction worker travel to site</li>
                          <li>Details of landscaping and planting associated with the development, including landscape type and associated area </li></ul><br>
                          There are two options to completing the waste arising in construction:<br><br>
                   
                   OPTION 1:<br>
                   Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                   The data input table requires:
                   
                   <ul><li> Drop-down selection of waste materials category, sub category and route</li>
                   <li> The quantity of waste to be disposed (in the units provided in the Units column of the table)</li>
                   <li> The mode of transport of waste and the distance travelled in kilometres, if available. There are sub-options for transport entry, as follows:</li>
                   <ol><li> If data availability allows entry of the mode of transport of the waste and distance travelled into the tool, please ensure that you have selected the ‘(excl. transport)’ options in the waste materials category.</li>
                   <li> If the mode of transport of the waste and distance is not available, please ensure that you have not selected the ‘(excl. transport)’ options in the waste materials category.</li></ol></ul><br>
                   For transport of waste material, where the mode of transport and estimated kilometres travelled data is available, one mode of transport can be entered per type of waste.<br><br>
                   
                   OPTION 2:<br>
                   Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                   The data input table requires:
                   
                   <ul><li> Drop-down selection of the construction spend</li></ul><br>
                          Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each activity detailed, as applicable."))
                              ))),
                        hr()
        )),
         tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "excav",
                
                tabPanel(title = tagList("Excavation Activities", icon("arrow-circle-right")), value = "excav", #  tagList("Clearance and Demolition Activities ", icon("arrow-circle-right"))   check-circle
                         fluidRow(
                           column(width = 12,
                                  h4("Excavation Activities Emissions (tCO2e):  ", textOutput(outputId = ns("sum_excav_tCO2"), inline = T)),
                                  HTML("<br> </br>"),
                                  # h5("Select rows to add to table:"),
                                  # splitLayout(numericInput(ns("excav_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                  #             actionButton(inputId = ns("excav_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                  # rHandsontableOutput(ns("excavTbl")),
                                  # tags$style(HTML(rhandsontable_headstyle))
                                  # p("* Additional rows can be added to the table by right-clicking on the table")
                                  column(6,offset = 6,
                                         HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                         ### tags$head() This is to change the color of "Add a new row" button
                                         tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("excav_Add_row_head"),label = "Add", class="butt2") ),
                                         tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("excav_mod_row_head"),label = "Edit", class="butt4") ),
                                         tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("excav_Del_row_head"),label = "Delete", class="butt3") ),
                                         ### Optional: a html button
                                         # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                         HTML('</div>') ),
                                  
                                  column(12,
                                         DT::DTOutput(ns("excavTbl"))
                                  ),
                                  tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                  div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("excav_Template_download"),label = "Download Template", class="butt5") ),
                                  tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                  tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                          fileInput2(inputId = ns("excav_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                     accept = ".xlsx", multiple = F, width = "100px", progress = F))
                           )
                         )
                ),
                
                tabPanel(title = tagList("Construction Activities", icon("arrow-circle-right")), value = "constract",
                         fluidRow(#style = "border: 4px double red;",
                                  column(width = 12,
                                         h4("Construction Activities Emissions (tCO2e):  ", textOutput(outputId = ns("sum_const_tCO2"), inline = T)),
                                         HTML("<br> </br>")
                                  )
                         ),
                         fluidRow(
                           column(width = 12,
                                  div(id = ns("constrTbl_box"),
                                      tags$div(title="The Hourly Fuel Use table can be used either in combination with the Total Fuel Use table, or it can be used alone", 
                                               h4("Hourly Fuel Use", tags$sup(icon("question-circle")))),
                                      # h5("Select rows to add to table:"),
                                      # splitLayout(numericInput(ns("constract_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                      #             actionButton(inputId = ns("constract_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                      # rHandsontableOutput(ns("constrTbl")),
                                      # tags$style(HTML(rhandsontable_headstyle)),
                                      column(6,offset = 6,
                                             HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                             ### tags$head() This is to change the color of "Add a new row" button
                                             tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constr_Add_row_head"),label = "Add", class="butt2") ),
                                             tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constr_mod_row_head"),label = "Edit", class="butt4") ),
                                             tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constr_Del_row_head"),label = "Delete", class="butt3") ),
                                             ### Optional: a html button
                                             # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                             HTML('</div>') ),
                                      
                                      column(12,
                                             DT::DTOutput(ns("constrTbl"))
                                      ),
                                      tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                      div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("constr_Template_download"),label = "Download Template", class="butt5") ),
                                      tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                      tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                              fileInput2(inputId = ns("constr_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                         accept = ".xlsx", multiple = F, width = "100px", progress = F)),
                                      
                                      tags$div(title="The Total Fuel Use table can be used either in combination with the Hourly Fuel Use table, or it can be used alone", 
                                               h4("Total Fuel Use", tags$sup(icon("question-circle")))),
                                      # h5("Select rows to add to table:"),
                                      # splitLayout(numericInput(ns("constract_alt_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                      #             actionButton(inputId = ns("constract_alt_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                      # rHandsontableOutput(ns("constrTblAlt")),
                                      # tags$style(HTML(rhandsontable_headstyle))
                                      column(6,offset = 6,
                                             HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                             ### tags$head() This is to change the color of "Add a new row" button
                                             tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constrAlt_Add_row_head"),label = "Add", class="butt2") ),
                                             tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constrAlt_mod_row_head"),label = "Edit", class="butt4") ),
                                             tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constrAlt_Del_row_head"),label = "Delete", class="butt3") ),
                                             ### Optional: a html button
                                             # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                             HTML('</div>') ),
                                      
                                      column(12,
                                             DT::DTOutput(ns("constrAltTbl")) 
                                      ),
                                      tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                      div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("constrAlt_Template_download"),label = "Download Template", class="butt5") ),
                                      tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                      tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                              fileInput2(inputId = ns("constrAlt_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                         accept = ".xlsx", multiple = F, width = "100px", progress = F))
                                  )#,
                                  
                           )
                         ),
                         # fluidRow(
                         #   column(width = 12,
                         #          div(id = ns("constrTbl_alt_box"),
                         #              tags$div(title="The Total Fuel Use table can be used either in combination with the Hourly Fuel Use table, or it can be used alone", 
                         #                       h4("Total Fuel Use", tags$sup(icon("question-circle")))),
                         #              h5("Select rows to add to table:"),
                         #              splitLayout(numericInput(ns("constract_alt_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                         #                          actionButton(inputId = ns("constract_alt_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                         #              rHandsontableOutput(ns("constrTblAlt")),
                         #              tags$style(HTML(rhandsontable_headstyle))
                         #          )#,
                         #          
                         #   )
                         # )
                ),
                
                tabPanel(title = tagList("Water Use During Construction Activities", icon("arrow-circle-right")), value = "wuconstract",
                         fluidRow(
                           column(width = 12,
                                  h4("Construction Water Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_cwuse_tCO2"), inline = T)),
                                  HTML("<br> </br>"),
                                  # h5("Select rows to add to table:"),
                                  # splitLayout(numericInput(ns("wuconstract_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                  #             actionButton(inputId = ns("wuconstract_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                  # rHandsontableOutput(ns("wuconstrTbl")),
                                  # tags$style(HTML(rhandsontable_headstyle))
                                  column(6,offset = 6,
                                         HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                         ### tags$head() This is to change the color of "Add a new row" button
                                         tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wuconstr_Add_row_head"),label = "Add", class="butt2") ),
                                         tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wuconstr_mod_row_head"),label = "Edit", class="butt4") ),
                                         tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wuconstr_Del_row_head"),label = "Delete", class="butt3") ),
                                         ### Optional: a html button
                                         # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                         HTML('</div>') ),
                                  
                                  column(12,
                                         DT::DTOutput(ns("wuconstrTbl"))
                                  ),
                                  tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                  div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("wuconstr_Template_download"),label = "Download Template", class="butt5") ),
                                  tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                  tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                          fileInput2(inputId = ns("wuconstr_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                     accept = ".xlsx", multiple = F, width = "100px", progress = F))
                           )
                         )
                ),
                
                tabPanel(title = tagList("Construction Worker Travel To Site", icon("arrow-circle-right")), value = "worktravelconstract",
                         fluidRow(
                           column(width = 12,
                                  h4("Construction Worker Travel Emissions (tCO2e):  ", textOutput(outputId = ns("sum_wtcv_tCO2"), inline = T)),
                                  HTML("<br> </br>"),
                                  # h5("Select rows to add to table:"),
                                  # splitLayout(numericInput(ns("wtravel_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                  #             actionButton(inputId = ns("wtravel_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                  # rHandsontableOutput(ns("worktravelconstrTbl")),
                                  # tags$style(HTML(rhandsontable_headstyle))
                                  column(6,offset = 6,
                                         HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                         ### tags$head() This is to change the color of "Add a new row" button
                                         tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wtconstr_Add_row_head"),label = "Add", class="butt2") ),
                                         tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wtconstr_mod_row_head"),label = "Edit", class="butt4") ),
                                         tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wtconstr_Del_row_head"),label = "Delete", class="butt3") ),
                                         ### Optional: a html button
                                         # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                         HTML('</div>') ),
                                  
                                  column(12,
                                         DT::DTOutput(ns("wtconstrTbl"))
                                  ),
                                  tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                  div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("wtconstr_Template_download"),label = "Download Template", class="butt5") ),
                                  tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                  tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                          fileInput2(inputId = ns("wtconstr_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                     accept = ".xlsx", multiple = F, width = "100px", progress = F))
                           )
                         )
                ),
                
                # tabPanel(title = tagList("Landscaping and Vegetation", icon("arrow-circle-right")), value = "landvegconstract",
                #          fluidRow(
                #            column(width = 12,
                #                   h4("Landscaping and Vegetation Emissions (tCO2e):  ", textOutput(outputId = ns("sum_landv_tCO2"), inline = T)),
                #                   HTML("<br> </br>"),
                #                   rHandsontableOutput(ns("landvegconstrTbl")),
                #                   tags$style(HTML(rhandsontable_headstyle))
                #            )
                #          )
                # ),
                
				tabPanel(title = tagList("Construction Waste", icon("arrow-circle-right")), value = "constrwaste",
                         fluidRow(
                           column(width = 12,
                                  h4("Construction Waste Emissions (tCO2e):  ", textOutput(outputId = ns("sum_cwaste_tCO2"), inline = T)),
                                  HTML("<br> </br>")
                           )
                         ),
                         fluidRow(
                           column(width = 12,
                                  checkboxInput(inputId = ns("constrwasteToggle"),
                                                label = HTML(paste0("If detailed information on Construction Waste is <b>not</b> available check this box.",
                                                                    " <b>Warning!</b> This action will <b>clear all data</b> from the detailed table below.")),
                                                value = F),
                                  div(id = ns("constrwasteTbl_box"),
                                      h5(HTML("<b>Note:</b> If detailed information on waste transport is available, select emission factors labelled with 
                                      ‘(excl. transport)’ in the waste type column of the below table and proceed to complete the waste transport columns with 
                                      the transport data. If information on waste transport is not available, select the standard emission factors, which 
                                      include a transport estimate, and leave the waste transport columns blank.")),
                                      # h5("Select rows to add to table:"),
                                      # splitLayout(numericInput(ns("conswaste_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                      #             actionButton(inputId = ns("conswaste_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                      # rHandsontableOutput(ns("constrwasteTbl")),
                                      # tags$style(type="text/css", paste0("#",ns("constrwasteTbl"), rhandsontable_headstyle)),
                                      # p("* Additional rows can be added to the table by right-clicking on the table")
                                      column(6,offset = 6,
                                             HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                             ### tags$head() This is to change the color of "Add a new row" button
                                             tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constrwaste_Add_row_head"),label = "Add", class="butt2") ),
                                             tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constrwaste_mod_row_head"),label = "Edit", class="butt4") ),
                                             tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                             div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("constrwaste_Del_row_head"),label = "Delete", class="butt3") ),
                                             ### Optional: a html button
                                             # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                             HTML('</div>') ),
                                      
                                      column(12,
                                             DT::DTOutput(ns("constrwasteTbl"))
                                      ),
                                      tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                      div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("constrwaste_Template_download"),label = "Download Template", class="butt5") ),
                                      tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                      tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;", 
                                              fileInput2(inputId = ns("constrwaste_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                         accept = ".xlsx", multiple = F, width = "100px", progress = F))
                                  ),
                                  hidden(
                                    div(id = ns("constrwasteProjSize_box"),
                                        column(width = 3,
                                               shinyWidgets::autonumericInput(width = 200, inputId = ns("constCost"), label = "Construction Cost", value = 0,
                                                                              digitGroupSeparator = ",",decimalPlaces = 0, align = "left", currencySymbol = "\u20ac")
                                        ),
                                        column(width = 4,
                                               h4("Construction Waste Emissions (tCO2e):  ", textOutput(ns("cwaste_tCO2_text"), inline = T))
                                        )
                                    )
                                  )
                           )
                         )
                ),
                tabPanel(title = tagList("Carbon Saving Opportunities", icon("check-circle")), value = "csavo",
                         fluidRow(
                           column(width = 12,
                                  h4(strong("Carbon Savings Identified but not Implemented")),
                                  # rHandsontableOutput(ns("csavoNoImplTbl")),
                                  # tags$style(type="text/css", paste0("#",ns("csavoNoImplTbl"), rhandsontable_headstyle))
                                  column(6,offset = 6,
                                         HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                         ### tags$head() This is to change the color of "Add a new row" button
                                         tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_Add_row_head"),label = "Add", class="butt2") ),
                                         tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_mod_row_head"),label = "Edit", class="butt4") ),
                                         tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_Del_row_head"),label = "Delete", class="butt3") ),
                                         ### Optional: a html button
                                         # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                         HTML('</div>') ),
                                  column(12,
                                         DT::DTOutput(ns("csavoNoImplTbl"))
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 12,
                                  h4(strong("Carbon Savings Identified and Implemented")),
                                  # rHandsontableOutput(ns("csavoImplTbl")),
                                  # tags$style(type="text/css", paste0("#",ns("csavoImplTbl"), rhandsontable_headstyle))
                                  column(6,offset = 6,
                                         HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                         ### tags$head() This is to change the color of "Add a new row" button
                                         tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_Add_row_head"),label = "Add", class="butt2") ),
                                         tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_mod_row_head"),label = "Edit", class="butt4") ),
                                         tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                         div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_Del_row_head"),label = "Delete", class="butt3") ),
                                         ### Optional: a html button
                                         # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                         HTML('</div>') ),
                                  column(12,
                                         DT::DTOutput(ns("csavoImplTbl"))
                                  )
                           )
                         )
                )
         )
    )
    )
  )
}

const_server <- function(id, option_number, thetitle, theoutput, appR_returned){
  
  source(file = "functions/consWastePatch.R")
  
  # Switch selection depending on Road or Rail Option
  if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
    dropdown_options_excavTbl <- excavTbl_dropdown_opts_road
    dropdown_options_constrTbl <- constrTbl_dropdown_opts_road
    dropdown_options_wuconstrTbl <- wuconstrTbl_dropdown_opts_road
    dropdown_options_worktravelconstrTbl <- worktravelconstrTbl_dropdown_opts_road
    dropdown_options_landvegconstrTbl <- landvegconstrTbl_dropdown_opts_road
    dropdown_options <- wasteTbl_dropdown_opts_road
    trans_mode_options <- transmodewasteTbl_dropdown_opts_road
    download_template_filename_excav <- "Road_Construction_Excav.xlsx"
  } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
    dropdown_options_excavTbl <- excavTbl_dropdown_opts_rail
    dropdown_options_constrTbl <- constrTbl_dropdown_opts_rail
    dropdown_options_wuconstrTbl <- wuconstrTbl_dropdown_opts_rail
    dropdown_options_worktravelconstrTbl <- worktravelconstrTbl_dropdown_opts_rail
    dropdown_options_landvegconstrTbl <- landvegconstrTbl_dropdown_opts_rail
    dropdown_options <- wasteTbl_dropdown_opts_rail
    trans_mode_options <- transmodewasteTbl_dropdown_opts_rail
    download_template_filename_excav <- "Rail_Construction_Excav.xlsx"
  } else if (stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
    dropdown_options_excavTbl <- excavTbl_dropdown_opts_road
    dropdown_options_constrTbl <- constrTbl_dropdown_opts_road
    dropdown_options_wuconstrTbl <- wuconstrTbl_dropdown_opts_road
    dropdown_options_worktravelconstrTbl <- worktravelconstrTbl_dropdown_opts_road
    dropdown_options_landvegconstrTbl <- landvegconstrTbl_dropdown_opts_road
    dropdown_options <- wasteTbl_dropdown_opts_road
    trans_mode_options <- transmodewasteTbl_dropdown_opts_road
    download_template_filename_excav <- "Road_Construction_Excav.xlsx"
  } else {
    #print("No matching data")
  }
  
  # Initial Values for use in tables/lookups
  cat_init_excavTbl <- dropdown_options_excavTbl %>% pull(Category) %>% unique %>% stringr::str_sort(numeric = TRUE)
  activ_init_constrTbl <- dropdown_options_constrTbl %>% pull(`Activity Category`) %>% unique %>% stringr::str_sort(numeric = TRUE)
  projSize_init <- projectSizeDefaults %>% filter(Unit == "Weeks") %>% pull(`Size of Project`) %>% unique %>% stringr::str_sort(numeric = TRUE)
  activ_init_wuconstrTbl <- dropdown_options_wuconstrTbl %>% pull(`Activity Type`) %>% unique %>% stringr::str_sort(numeric = TRUE)
  travel_options_init <- dropdown_options_worktravelconstrTbl %>% pull(Vehicle) %>% unique %>% stringr::str_sort(numeric = TRUE)
  landveg_options_init <- dropdown_options_landvegconstrTbl %>% pull(`Carbon Sink`) %>% unique %>% stringr::str_sort(numeric = TRUE)
	waste_init_options <- dropdown_options %>% pull(`Waste Type`) %>% unique %>% stringr::str_sort(numeric = TRUE)
  
  # definition of data.table for Excav table
  DF_excavTbl = data.table(`Excavation Category` = rep(cat_init_excavTbl[1],rhot_rows), 
                           `Excavation Sub Category` = NA_character_, 
                           Activity = NA_character_,
                           Quantity = 0.0,
                           Unit = NA_character_,
                           `Activity tCO2e` = 0.0,
                           Comments = NA_character_,
                           stringsAsFactors = F, check.names = FALSE)
  
  DF_constrTbl = data.table(`Activity Category` = rep(activ_init_constrTbl[1],rhot_rows), 
                            `Energy Type` = NA_character_, 
                            `Fuel Use Per Hour` = 0.0,
                            Unit = NA_character_,
                            `Operating Time (Hours Per Day)` = 0.0,
                            `Total Days` = 1,
                            `Activity tCO2e` = 0.0,
                            Comments = NA_character_,
                            stringsAsFactors = F, check.names = FALSE)
  
  DF_constrTbl_alt = data.table(`Activity Category` = rep(activ_init_constrTbl[1],rhot_rows),
                                `Energy Type` = NA_character_, 
                                `Total Fuel Use` = 0.0,
                                Unit = NA_character_,
                                `Activity tCO2e` = 0.0,
                                Comments = NA_character_,
                                stringsAsFactors = F, check.names = FALSE)
  
  DF_constrProjSizeTbl = data.table(`Size of Project` = projSize_init[1],
                                    `Length of Project in Weeks` = 0,
                                    Unit = NA_character_,
                                    `Total tCO2e` = 0.0,
                                    stringsAsFactors = F, check.names = F)
  
  DF_wuconstrTbl = data.table(`Activity Type` = rep(activ_init_wuconstrTbl[1], rhot_rows),
                              `Water Use` = NA_character_,
                              Quantity = 0.0, 
                              Unit = NA_character_, 
                              `Activity tCO2e` = 0.0,
                              Comments = NA_character_,
                              stringsAsFactors = F, check.names = F)
  
  DF_worktravelconstrTbl = data.table(`Mode of Transport` = rep(travel_options_init[1], rhot_rows),
                                      `Total distance travelled by workers during construction (km)` = 0.0,
                                      `Transport tCO2e` = 0.0,
                                      `Comments` = NA_character_,
                                      stringsAsFactors = F, check.names = F)
  
  # DF_landvegconstrTbl = data.table(`Vegetation Type` = rep(landveg_options_init[1], rhot_rows),
  #                             Quantity = 0.0, 
  #                             Unit = NA_character_, 
  #                             `Carbon Sink tCO2e (added)` = 0.0,
  #                             `Comments` = NA_character_,
  #                             stringsAsFactors = F, check.names = F)
  
  DF_constrwaste = data.table(`Waste Type` = as.character(rep(waste_init_options[1], 5)), #+# change 5 to object defined in global.r
                              `Waste Route` = as.character(NA),
                              Quantity = 0.0,
                              Unit = as.character(NA),
                              `Transport Mode` = as.character(NA),
                              Distance = 0.0,
                              `Distance Unit` = as.character(NA),
                              `Waste Processing Carbon tCO2e` = 0.0,
                              `Transport tCO2e` = 0.0,
                              Comments = as.character(NA),
                              stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = rep(NA_character_, rhot_rows), 
                              `Rationale for why the option has not been taken forward for implementation` = rep(NA_character_, rhot_rows), 
                              stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = rep(NA_character_, rhot_rows), 
                            `Rationale for implementation` = rep(NA_character_, rhot_rows), 
                            stringsAsFactors = F, check.names = FALSE)
  
  
  # Define reactiveValues
  excavvalues <- reactiveValues(data=DF_excavTbl)
  constrvalues <- reactiveValues(data=DF_constrTbl)
  constr_alt_values <- reactiveValues(data=DF_constrTbl_alt)
  constrProjSizevalues <- reactiveValues(data=DF_constrProjSizeTbl)
  constrProjSizevalVal <- reactiveValues(data=0.0)
  wuconstrvalues <- reactiveValues(data=DF_wuconstrTbl)
  worktravelconstrvalues <- reactiveValues(data=DF_worktravelconstrTbl)
  #landvegconstrvalues <- reactiveValues(data=DF_landvegconstrTbl)
  constrwastevalues <- reactiveValues(data=DF_constrwaste)
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  sum_excav_tCO2 <- reactiveValues(data=0.0)#sum(DF_excavTbl$`Activity kgCO2e`))
  sum_constdetail_tCO2 <- reactiveValues(data=0.0)
  sum_constprojsize_tCO2 <- reactiveValues(data=0.0)
  sum_const_tCO2 <- reactiveValues(data=0.0)#sum(DF_constrTbl$`Activity kgCO2e`))
  sum_cwuse_tCO2 <- reactiveValues(data=0.0)#sum(DF_wuconstrTbl$`Activity kgCO2e`))
  #sum_landv_tCO2 <- reactiveValues(data=0.0)#sum(DF_landvegconstrTbl$`Carbon Sink kgCO2e (added)`))
  sum_wtcv_tCO2 <- reactiveValues(data=0.0)#sum(DF_worktravelconstrTbl$`Transport kgCO2e`))
  sum_cwaste_tCO2 <- reactiveValues(data=0.0)
  sum_cwaste_trans_tCO2 <- reactiveValues(data=0.0)
  
  sum_totalconst_tCO2 <- reactiveValues(data=0.0)
  sum_totalconst_waste_tCO2 <- reactiveValues(data=0.0)
  
  DF_returned <- data.table(Option = c(option_number, option_number, option_number, option_number, option_number, option_number, option_number, option_number),
                            Stage = c("Construction","Construction","Construction","Construction","Construction","Construction","Construction","Construction"),
                            Measure = c("Excavation","Construction Water Use","Plant Use","Construction Worker Travel to Site",
                                        "Construction Waste Disposal","Construction Waste Transport","Total","Waste Total"),
                            Value = c(0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0),
                            stringsAsFactors = F, check.names = FALSE)
  
  const_returned <- reactiveValues(data=DF_returned,
                                   carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                             Stage = c("Construction"),
                                                             Description = c(""), Rationale = c("")),
                                   carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                          Stage = c("Construction"),
                                                          Description = c(""), Rationale = c("")),
								                   excavTblResave = DF_excavTbl,
                                   constrTblResave = DF_constrTbl,
								                   constrTblAltResave = DF_constrTbl_alt,
                                   wuconstrTblResave = DF_wuconstrTbl,
                                   constrProjSizeTblResave = DF_constrProjSizeTbl,
                                   worktravelconstrTblResave = DF_worktravelconstrTbl,
                                   #landvegconstrTblResave = DF_landvegconstrTbl,
								                   constrwasteTblResave = DF_constrwaste,
                                   csavoNoImplTblResave = DF_csavoNoImpl,
                                   csavoImplTblResave = DF_csavoImpl)
  							
  
  moduleServer(id,
               function(input, output, session){
                 
                 ns <- session$ns
                 
                 constrwasteProjSizeval <- reactive(input$constCost * 0.0009248)
                 
                 sum_const_tCO2_react <- reactive(
                   sum(sum_constdetail_tCO2$data)
                   )
                 
                 
                 sum_cwaste_tCO2_react <- reactive(
                   sum(sum_cwaste_tCO2$data, constrwasteProjSizeval())
                 )
                 
                 sum_totalconst_tCO2_react <- reactive(
                   sum(sum_excav_tCO2$data, sum_const_tCO2_react(), sum_cwuse_tCO2$data, #sum_landv_tCO2$data, 
                       sum_wtcv_tCO2$data)
                 )
                 
                 sum_totalconst_waste_tCO2_react <- reactive(
                   sum(sum_excav_tCO2$data, sum_const_tCO2_react(), sum_cwuse_tCO2$data, #sum_landv_tCO2$data, 
                       sum_wtcv_tCO2$data, sum_cwaste_tCO2_react(), sum_cwaste_trans_tCO2$data)
                 )
                 
                 sum_totalconstWaste_tCO2_react <- reactive(sum(sum_cwaste_tCO2$data, constrwasteProjSizeval(), sum_cwaste_trans_tCO2$data))
                 
                 const_returned_react <- reactive({
                   c(sum_excav_tCO2$data, sum_cwuse_tCO2$data, sum_const_tCO2_react(),
                     sum_wtcv_tCO2$data, sum(sum_cwaste_tCO2$data, constrwasteProjSizeval()),
                     sum_cwaste_trans_tCO2$data, sum_totalconst_tCO2_react(), sum_totalconstWaste_tCO2_react())
                 })
                 
                 output$some_title <- renderText({thetitle})
                 
                 output$cwaste_tCO2_text <- renderText({formatC(round(constrwasteProjSizeval(), digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 output$sum_excav_tCO2 <- renderText({formatC(round(sum_excav_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_const_tCO2 <- renderText({formatC(round(sum_const_tCO2_react(), digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_cwuse_tCO2 <- renderText({formatC(round(sum_cwuse_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 #output$sum_landv_tCO2 <- renderText({formatC(round(sum_landv_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_wtcv_tCO2 <- renderText({formatC(round(sum_wtcv_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_cwaste_tCO2 <- renderText({formatC(round(sum(sum_cwaste_tCO2_react(), sum_cwaste_trans_tCO2$data), digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 #output$sum_totalconst_kgCO2 <- renderText({formatC(round(sum_totalconst_kgCO2$data, digits = 0), format="f", digits = 0, big.mark=',')})
                 output$sum_totalconst_tCO2 <- renderText({formatC(round(sum_totalconst_tCO2_react(), digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 output$sum_totalconst_waste_tCO2 <- renderText({formatC(round(sum_totalconst_waste_tCO2_react(), digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 
                 
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   CONST   appR_returned$loadReact")
                   
                   excavvalues$data = DF_excavTbl
                   constrvalues$data = DF_constrTbl
                   constr_alt_values$data = DF_constrTbl_alt
                   constrProjSizevalues$data = DF_constrProjSizeTbl
                   wuconstrvalues$data = DF_wuconstrTbl
                   worktravelconstrvalues$data = DF_worktravelconstrTbl
                   #landvegconstrvalues$data = DF_landvegconstrTbl
                   constrwastevalues$data = DF_constrwaste								  
                   csavoNoImplvalues$data = DF_csavoNoImpl
                   csavoImplvalues$data = DF_csavoImpl
                   
                   sum_excav_tCO2$data = 0.0
                   sum_constdetail_tCO2$data = 0.0
                   sum_constprojsize_tCO2$data = 0.0
                   sum_const_tCO2$data = 0.0
                   sum_cwuse_tCO2$data = 0.0
                   #sum_landv_tCO2$data = 0.0
                   sum_wtcv_tCO2$data = 0.0
                   sum_cwaste_tCO2$data = 0.0
                   sum_cwaste_trans_tCO2$data = 0.0
                   
                   sum_totalconst_tCO2$data = 0.0
                   sum_totalconst_waste_tCO2$data = 0.0
                   
                   const_returned$data$Value = c(0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0)
                   
                   const_returned$carbsaveimp$Description = c("")
                   const_returned$carbsaveimp$Rationale = c("")
                   const_returned$carbsavenotimp$Description = c("")
                   const_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   if (is.null(appR_returned$data[[paste0(id,"_excavTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                   
                   
                   tmpData <- as.data.table(appR_returned$data$inputs_data_frame)
                   # Construction cost
                   loadedInputValue <- as.logical(tmpData[Module==id & idInput=="constrwasteToggle", Value])
                   #updateCheckboxInput(getDefaultReactiveDomain(), input = paste0("Opts-",id,"-constrwasteToggle"), value = loadedInputValue)
                   updateCheckboxInput(getDefaultReactiveDomain(), input = "constrwasteToggle", value = loadedInputValue)
                   
                   loadedInputValue <- as.numeric(tmpData[Module==id & idInput=="constCost", Value])
                   #shinyWidgets::updateAutonumericInput(session = session, inputId = paste0("Opts-",id,"-constCost"), value = loadedInputValue)
                   shinyWidgets::updateAutonumericInput(session = session, inputId = "constCost", value = loadedInputValue)
                   
                   
                   
                   # Load data from the load file into rhandsontables and reactivevalues
                   tmpData <- appR_returned$data[[paste0(id,"_excavTbl")]]
                   colnames(tmpData) <- colnames(DF_excavTbl)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   excavvalues$data <- tmpData
                   const_returned$excavTblResave = tmpData
                   
                   sum_excav_tCO2$data = sum(na.omit(as.numeric(tmpData$`Activity tCO2e`))) # get carbon emissions
                   
                   tmpData <- appR_returned$data[[paste0(id,"_constrTbl")]]
                   colnames(tmpData) <- colnames(DF_constrTbl)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   constrvalues$data <- tmpData
                   const_returned$constrTblResave = tmpData	
                   
                   # this is the new alternative cons df, if statement should catch new .sav files is TRUE and old if FALSE
                   tmpData2 <- appR_returned$data[[paste0(id,"_constrTblAlt")]]
                   
                   if (!is.null(tmpData2)){
                     colnames(tmpData2) <- colnames(DF_constrTbl_alt)
                     tmpData2$Comments <- as.character(tmpData2$Comments)
                     tmpData2$Unit <- as.character(tmpData2$Unit)
                     constr_alt_values$data <- tmpData2
                     const_returned$constrTblAltResave = tmpData2
                     
                     sum_constdetail_tCO2$data = sum(na.omit(as.numeric(tmpData$`Activity tCO2e`)), na.omit(as.numeric(tmpData2$`Activity tCO2e`)))
                   } else {
                     sum_constdetail_tCO2$data = sum(na.omit(as.numeric(tmpData$`Activity tCO2e`)))
                   }
                  
                   rm(tmpData2)
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_wuconstrTbl")]]
                   if (ncol(tmpData)==5){tmpData$Comments <- as.character(NA)}
                   colnames(tmpData) <- colnames(DF_wuconstrTbl)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   wuconstrvalues$data <- tmpData
                   const_returned$wuconstrTblResave = tmpData		
                   
                   sum_cwuse_tCO2$data = sum(na.omit(as.numeric(tmpData$`Activity tCO2e`))) # get carbon emissions
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_constrProjSizeTbl")]]
                   colnames(tmpData) <- colnames(DF_constrProjSizeTbl)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   constrProjSizevalues$data <- tmpData
                   const_returned$constrProjSizeTblResave = tmpData											   
                   sum_constprojsize_tCO2$data = sum(na.omit(as.numeric(tmpData$`Total tCO2e`)))
                   
                   sum_const_tCO2$data = sum(sum_constdetail_tCO2$data, sum_constprojsize_tCO2$data)
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_worktravelconstrTbl")]]
                   colnames(tmpData) <- colnames(DF_worktravelconstrTbl)
                   tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   worktravelconstrvalues$data <- tmpData
                   const_returned$worktravelconstrTblResave = tmpData		
                   
                   sum_wtcv_tCO2$data = sum(na.omit(as.numeric(tmpData$`Transport tCO2e`))) # get carbon emissions
                   
                   
                   
                   # tmpData <- appR_returned$data[[paste0(id,"_landvegconstrTbl")]]
                   # colnames(tmpData) <- colnames(DF_landvegconstrTbl)
                   # tmpData$Unit <- as.character(tmpData$Unit)
                   # tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   # landvegconstrvalues$data <- tmpData
                   # const_returned$landvegconstrTblResave = tmpData
                   # 
                   # sum_landv_tCO2$data = sum(na.omit(as.numeric(tmpData$`Carbon Sink tCO2e (added)`))) * -1.0 # get carbon emissions
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_constrwasteTbl")]]
                   colnames(tmpData) <- colnames(DF_constrwaste)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   tmpData$`Distance Unit` <- as.character(tmpData$`Distance Unit`)
                   
                   
                   ## add patch here
                   if (is.null(appR_returned$data$saveVersion)){
                     tmpData <- wastePatch(wasteTable = tmpData, dropdown_options = dropdown_options)
                   }
                   # browser()
                   ### continue
                   
                   constrwastevalues$data <- tmpData
                   const_returned$constrwasteTblResave = tmpData
                   
                   sum_cwaste_tCO2$data = sum(na.omit(tmpData$`Waste Processing Carbon tCO2e`))
                   
                   sum_cwaste_trans_tCO2$data = sum(na.omit(tmpData$`Transport tCO2e`))
                   
                   
                   sum_totalconst_tCO2$data <- sum(sum_excav_tCO2$data, sum_const_tCO2$data, sum_cwuse_tCO2$data, sum_wtcv_tCO2$data,
												sum_cwaste_tCO2$data) # , sum_landv_tCO2$data
                   
                   #const_returned$data$Value = c(sum_excav_tCO2$data, sum_cwuse_tCO2$data, sum_const_tCO2$data, sum_wtcv_tCO2$data, sum_landv_tCO2$data,
                    #                             sum_cwaste_tCO2$data, sum_cwaste_trans_tCO2$data, sum_totalconst_tCO2$data, sum_totalconst_waste_tCO2$data)
                   const_returned$data$Value = const_returned_react()
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   const_returned$csavoNoImplTblResave <- tmpData
                   csavoNoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Construction", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                   const_returned$carbsavenotimp = tmpdat
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for implementation` = as.character(`Rationale for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   const_returned$csavoImplTblResave <- tmpData
                   csavoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Construction", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for implementation`)]
                   const_returned$carbsaveimp = tmpdat
                   
                   }
                   
                 })
                 
                 
############################# RENDER EXCAV TABLE ####
                 
                 output$excavTbl <- DT::renderDT({
                   DT = excavvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(6), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$excav_Add_row_head, {
                   ### This is the pop up board for input a new row
                   category_options <- dropdown_options_excavTbl %>% filter(Category %like% "Earthworks") %>% pull(Category) %>% unique
                   subcategory_options <- dropdown_options_excavTbl %>% filter(Category %like% "Earthworks") %>% pull(`Sub Category`) %>% unique
                   
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("excav_add_col1"), label = "Excavation Category", choices = category_options),
                     selectizeInput(ns("excav_add_col2"), label = "Excavation Sub Category", choices = subcategory_options),
                     uiOutput(ns("excav_add_col3_out")),
                     #selectizeInput(ns("excav_add_col3"), label = "Activity", choices = trans_mode_options$Vehicle),
                     numericInput(ns("excav_add_col4"), label = "Quantity", value = 0),
                     uiOutput(ns("excav_add_col5_out")),
                     textInput(ns("excav_add_col6"), label = "Comments"),
                     actionButton(ns("excav_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 output$excav_add_col3_out <- renderUI({
                   selectizeInput(ns("excav_add_col3"), label = "Activity", choices = excav_activity_choices())
                 })
                 
                 excav_activity_choices <- reactive({
                   activity_options <- dropdown_options_excavTbl %>% 
                     filter(`Category` %like% "Earthworks" & `Sub Category` == input$excav_add_col2) %>%
                     select(`Activity`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$excav_add_col5_out <- renderUI({
                   selectizeInput(ns("excav_add_col5"), label = "Unit", choices = excav_unit_choices())
                 })
                 
                 excav_unit_choices <- reactive({
                   unit_options <- dropdown_options_excavTbl %>% 
                     filter(`Category` %like% "Earthworks" & `Sub Category` == input$excav_add_col2
                            & Activity == input$excav_add_col3) %>%
                     select(`Unit`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 observeEvent(input$excav_add_row_go, {
                   
                   new_row = data.frame(input$excav_add_col1,
                                        input$excav_add_col2,
                                        input$excav_add_col3,
                                        input$excav_add_col4,
                                        input$excav_add_col5,
                                        "Activity tCO2e" = 0,
                                        input$excav_add_col6) %>%
                     dplyr::left_join(., dropdown_options_excavTbl[, c("Activity","kgCO2e per unit")],
                                      by = c("input.excav_add_col3"="Activity")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.excav_add_col4 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   excavvalues$data <- data.table(rbind(excavvalues$data, new_row, use.names = F))
                   
                   sum_excav_tCO2$data <- sum(na.omit(as.numeric(excavvalues$data$`Activity tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$excavTblResave = excavvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(input$excav_Del_row_head,{
                   showModal(
                     if(length(input$excavTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$excavTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("excav_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$excav_del_row_ok, {
                   
                   excavvalues$data=excavvalues$data[-input$excavTbl_rows_selected,]
                   
                   sum_excav_tCO2$data <- sum(na.omit(as.numeric(excavvalues$data$`Activity tCO2e`)))
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$excavTblResave = excavvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(input$excav_mod_row_head, {
                   
                   category_options <- dropdown_options_excavTbl %>% filter(Category %like% "Earthworks") %>% pull(Category) %>% unique
                   subcategory_options <- dropdown_options_excavTbl %>% filter(Category %like% "Earthworks") %>% pull(`Sub Category`) %>% unique
                   
                   showModal(
                     if(length(input$excavTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("excav_mod_col1"), label = "Excavation Category", choices = category_options,
                                        selected = excavvalues$data[input$excavTbl_rows_selected,1]),
                         selectizeInput(ns("excav_mod_col2"), label = "Excavation Sub Category", choices = subcategory_options,
                                        selected = excavvalues$data[input$excavTbl_rows_selected,2]),
                         uiOutput(ns("excav_mod_col3_out")),
                         numericInput(ns("excav_mod_col4"), label = "Quantity", value = excavvalues$data[input$excavTbl_rows_selected,4]),
                         uiOutput(ns("excav_mod_col5_out")),
                         textInput(ns("excav_mod_col6"), label = "Comments", value = excavvalues$data[input$excavTbl_rows_selected,7]),
                         
                         hidden(numericInput(ns("excav_mod_rown"), value = input$excavTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("excav_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$excav_mod_col3_out <- renderUI({
                   selectizeInput(ns("excav_mod_col3"), label = "Activity", choices = excav_activity_choices_mod(), 
                                  selected = excavvalues$data[input$excavTbl_rows_selected,3])
                 })
                 
                 excav_activity_choices_mod <- reactive({
                   activity_options <- dropdown_options_excavTbl %>% 
                     filter(`Category` %like% "Earthworks" & `Sub Category` == input$excav_mod_col2) %>%
                     select(`Activity`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$excav_mod_col5_out <- renderUI({
                   selectizeInput(ns("excav_mod_col5"), label = "Unit", choices = excav_unit_choices_mod(), 
                                  selected = excavvalues$data[input$excavTbl_rows_selected,5])
                 })
                 
                 excav_unit_choices_mod <- reactive({
                   unit_options <- dropdown_options_excavTbl %>% 
                     filter(`Category` %like% "Earthworks" & `Sub Category` == input$excav_mod_col2
                            & Activity == input$excav_mod_col3) %>%
                     select(`Unit`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 observeEvent(input$excav_confirm_mod, {
                   
                   new_row = data.frame(input$excav_mod_col1,
                                        input$excav_mod_col2,
                                        input$excav_mod_col3,
                                        input$excav_mod_col4,
                                        input$excav_mod_col5,
                                        "Activity tCO2e" = 0,
                                        input$excav_mod_col6) %>%
                     dplyr::left_join(., dropdown_options_excavTbl[, c("Activity","kgCO2e per unit")],
                                      by = c("input.excav_mod_col3"="Activity")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.excav_mod_col4 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   excavvalues$data[input$excav_mod_rown,] <- new_row
                   
                   sum_excav_tCO2$data <- sum(na.omit(as.numeric(excavvalues$data$`Activity tCO2e`)))
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$excavTblResave = excavvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$excav_Template_download <- downloadHandler(
                   filename = function(){download_template_filename_excav},
                   content =function(file){file.copy(from = paste0("Templates/",download_template_filename_excav),to = file)}
                 )
                 
                 observeEvent(input$excav_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$excav_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(excavvalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     templateIn_data <- bind_rows(excavvalues$data, templateIn) %>%
                       dplyr::left_join(., dropdown_options_excavTbl[, c("Activity","kgCO2e per unit")], by = c("Activity"="Activity")) %>%
                       dplyr::mutate(`Activity tCO2e` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Quantity > 0)
                     
                     excavvalues$data <- templateIn_data
                     
                     sum_excav_tCO2$data <- sum(na.omit(as.numeric(excavvalues$data$`Activity tCO2e`)))
                     sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                     sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                     
                     const_returned$data$Value = const_returned_react()
                     const_returned$excavTblResave = excavvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
##################### RENDER CONSTR TABLE ####
                 
                 output$constrTbl <- DT::renderDT({
                   DT = constrvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(7), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$constr_Add_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("constr_add_col1"), label = "Activity Category", choices = activ_init_constrTbl),
                     selectizeInput(ns("constr_add_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown),
                     numericInput(ns("constr_add_col3"), label = "Fuel Use Per Hour", value = 0),
                     uiOutput(ns("constr_add_col4_out")),
                     numericInput(ns("constr_add_col5"), label = "Operating Time (Hours Per Day)", value = 0),
                     numericInput(ns("constr_add_col6"), label = "Total Days", value = 0),
                     textInput(ns("constr_add_col7"), label = "Comments"),
                     actionButton(ns("constr_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$constr_add_row_go, {
                   #browser()
                   new_row = data.frame(input$constr_add_col1,
                                        input$constr_add_col2,
                                        input$constr_add_col3,
                                        input$constr_add_col4,
                                        input$constr_add_col5,
                                        input$constr_add_col6,
                                        "Activity tCO2e" = 0,
                                        input$constr_add_col7) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.constr_add_col2" = "Fuel")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.constr_add_col3 * input.constr_add_col5 * input.constr_add_col6 *
                                     `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   constrvalues$data <- data.table(rbind(constrvalues$data, new_row, use.names = F))
                   
                   sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                   sum_const_tCO2$data <- sum_const_tCO2_react()
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrTblResave = constrvalues$data
                   
                   removeModal()
                 })
                 
                 output$constr_add_col4_out <- renderUI({
                   selectizeInput(ns("constr_add_col4"), label = "Unit", choices = constr_unit_choices())
                 })
                 
                 constr_unit_choices <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$constr_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$constr_Del_row_head,{
                   showModal(
                     if(length(input$constrTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$constrTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("constr_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$constr_del_row_ok, {
                   
                   constrvalues$data=constrvalues$data[-input$constrTbl_rows_selected,]
                   
                   sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                   sum_const_tCO2$data <- sum_const_tCO2_react()
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()

                   const_returned$data$Value = const_returned_react()
                   const_returned$constrTblResave = constrvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$constr_mod_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(
                     if(length(input$constrTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("constr_mod_col1"), label = "Activity Category", choices = activ_init_constrTbl, 
                                        selected = constrvalues$data[input$constrTbl_rows_selected,1]),
                         selectizeInput(ns("constr_mod_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown, 
                                        selected = constrvalues$data[input$constrTbl_rows_selected,2]),
                         numericInput(ns("constr_mod_col3"), label = "Fuel Use Per Hour", value = constrvalues$data[input$constrTbl_rows_selected,3]),
                         uiOutput(ns("constr_mod_col4_out")),
                         numericInput(ns("constr_mod_col5"), label = "Operating Time (Hours Per Day)", value = constrvalues$data[input$constrTbl_rows_selected,5]),
                         numericInput(ns("constr_mod_col6"), label = "Total Days", value = constrvalues$data[input$constrTbl_rows_selected,6]),
                         textInput(ns("constr_mod_col7"), label = "Comments", value = constrvalues$data[input$constrTbl_rows_selected,8]),
                         
                         hidden(numericInput(ns("constr_mod_rown"), value = input$constrTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("constr_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$constr_mod_col4_out <- renderUI({
                   selectizeInput(ns("constr_mod_col4"), label = "Unit", choices = constr_unit_choices_mod(), 
                                  selected = constrvalues$data[input$constrTbl_rows_selected,4])
                 })
                 
                 constr_unit_choices_mod <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$constr_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 observeEvent(input$constr_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$constr_mod_col1,
                                        input$constr_mod_col2,
                                        input$constr_mod_col3,
                                        input$constr_mod_col4,
                                        input$constr_mod_col5,
                                        input$constr_mod_col6,
                                        "Activity tCO2e" = 0,
                                        input$constr_mod_col7) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.constr_mod_col2" = "Fuel")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.constr_mod_col3 * input.constr_mod_col5 * input.constr_mod_col6 *
                                     `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   constrvalues$data[input$constr_mod_rown,] <- new_row
                   
                   sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                   sum_const_tCO2$data <- sum_const_tCO2_react()
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrTblResave = constrvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$constr_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Construction_Const.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Construction_Const.xlsx",to = file)}
                 )
                 
                 observeEvent(input$constr_Template_upload$name, {
                  
                   templateIn <- readxl::read_xlsx(input$constr_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(constrvalues$data)[1:3])){
                     
                     if (typeof(templateIn$`Fuel Use Per Hour`) == "character" | typeof(templateIn$`Operating Time (Hours Per Day)`) == "character" | 
                         typeof(templateIn$`Total Days`) == "character"){
                       templateIn$`Fuel Use Per Hour` <- as.numeric(templateIn$`Fuel Use Per Hour`)
                       templateIn$`Operating Time (Hours Per Day)` <- as.numeric(templateIn$`Operating Time (Hours Per Day)`)
                       templateIn$`Total Days` <- as.numeric(templateIn$`Total Days`)
                     }
                     
                     templateIn_data <- bind_rows(constrvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("Energy Type" = "Fuel")) %>%
                       dplyr::mutate(`Activity tCO2e` = `Fuel Use Per Hour` * `Operating Time (Hours Per Day)` * `Total Days`
                                     * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Fuel Use Per Hour` > 0)
                     
                     constrvalues$data <- templateIn_data
                     
                     sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                     sum_const_tCO2$data <- sum_const_tCO2_react()
                     
                     sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                     sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                     
                     const_returned$data$Value = const_returned_react()
                     const_returned$constrTblResave = constrvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
##################### RENDER CONSTR Alternative TABLE ####
                 
                 output$constrAltTbl <- DT::renderDT({
                   DT = constr_alt_values$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(5), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$constrAlt_Add_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("constrAlt_add_col1"), label = "Activity Category", choices = activ_init_constrTbl),
                     selectizeInput(ns("constrAlt_add_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown),
                     numericInput(ns("constrAlt_add_col3"), label = "Total Fuel Use", value = 0),
                     uiOutput(ns("constrAlt_add_col4_out")),
                     textInput(ns("constrAlt_add_col5"), label = "Comments"),
                     actionButton(ns("constrAlt_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$constrAlt_add_row_go, {
                   #browser()
                   new_row = data.frame(input$constrAlt_add_col1,
                                        input$constrAlt_add_col2,
                                        input$constrAlt_add_col3,
                                        input$constrAlt_add_col4,
                                        "Activity tCO2e" = 0,
                                        input$constrAlt_add_col5) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.constrAlt_add_col2" = "Fuel")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.constrAlt_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   constr_alt_values$data <- data.table(rbind(constr_alt_values$data, new_row, use.names = F))
                   
                   sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                   sum_const_tCO2$data <- sum_const_tCO2_react()
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrTblAltResave = constr_alt_values$data
                   
                   removeModal()
                 })
                 
                 output$constrAlt_add_col4_out <- renderUI({
                   selectizeInput(ns("constrAlt_add_col4"), label = "Unit", choices = constrAlt_unit_choices())
                 })
                 
                 constrAlt_unit_choices <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$constrAlt_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$constrAlt_Del_row_head,{
                   showModal(
                     if(length(input$constrAltTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$constrAltTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("constrAlt_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$constrAlt_del_row_ok, {
                   
                   constr_alt_values$data=constr_alt_values$data[-input$constrAltTbl_rows_selected,]
                   
                   sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                   sum_const_tCO2$data <- sum_const_tCO2_react()
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrTblAltResave = constr_alt_values$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$constrAlt_mod_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(
                     if(length(input$constrAltTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("constrAlt_mod_col1"), label = "Activity Category", choices = activ_init_constrTbl,
                                        selected = constr_alt_values$data[input$constrAltTbl_rows_selected,1]),
                         selectizeInput(ns("constrAlt_mod_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown,
                                        selected = constr_alt_values$data[input$constrAltTbl_rows_selected,2]),
                         numericInput(ns("constrAlt_mod_col3"), label = "Total Fuel Use", value = constr_alt_values$data[input$constrAltTbl_rows_selected,3]),
                         uiOutput(ns("constrAlt_mod_col4_out")),
                         textInput(ns("constrAlt_mod_col5"), label = "Comments", value = constr_alt_values$data[input$constrAltTbl_rows_selected,6]),
                         
                         hidden(numericInput(ns("constrAlt_mod_rown"), value = input$constrAltTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("constrAlt_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$constrAlt_mod_col4_out <- renderUI({
                   selectizeInput(ns("constrAlt_mod_col4"), label = "Unit", choices = constrAlt_unit_choices_mod(),
                                  selected = constr_alt_values$data[input$constrAltTbl_rows_selected,4])
                 })
                 
                 constrAlt_unit_choices_mod <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$constrAlt_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 observeEvent(input$constrAlt_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$constrAlt_mod_col1,
                                        input$constrAlt_mod_col2,
                                        input$constrAlt_mod_col3,
                                        input$constrAlt_mod_col4,
                                        "Activity tCO2e" = 0,
                                        input$constrAlt_mod_col5) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.constrAlt_mod_col2" = "Fuel")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.constrAlt_mod_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   constr_alt_values$data[input$constrAlt_mod_rown,] <- new_row
                   
                   sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                   sum_const_tCO2$data <- sum_const_tCO2_react()
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrTblAltResave = constr_alt_values$data
                   
                   removeModal()
                 })
                 
                 
                 output$constrAlt_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Construction_ConstAlt.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Construction_ConstAlt.xlsx",to = file)}
                 )
                 
                 observeEvent(input$constrAlt_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$constrAlt_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(constr_alt_values$data)[1:3])){
                     
                     if (typeof(templateIn$`Total Fuel Use`) == "character"){templateIn$`Total Fuel Use` <- as.numeric(templateIn$`Total Fuel Use`)}
                     
                     templateIn_data <- bind_rows(constr_alt_values$data, templateIn) %>%
                       dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("Energy Type" = "Fuel")) %>%
                       dplyr::mutate(`Activity tCO2e` = `Total Fuel Use` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Total Fuel Use` > 0)
                     
                     constr_alt_values$data <- templateIn_data
                     
                     sum_constdetail_tCO2$data <- sum(na.omit(as.numeric(constrvalues$data$`Activity tCO2e`)), na.omit(as.numeric(constr_alt_values$data$`Activity tCO2e`)))
                     sum_const_tCO2$data <- sum_const_tCO2_react()
                     
                     sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                     sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                     
                     const_returned$data$Value = const_returned_react()
                     const_returned$constrTblAltResave = constr_alt_values$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
##################### RENDER SIZE OF PROJECT TABLE ####
                 
##################### RENDER WATER USE TABLE ####
                 
                 output$wuconstrTbl <- DT::renderDT({
                   DT = wuconstrvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(5), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$wuconstr_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("wuconstr_add_col1"), label = "Activity Type", choices = dropdown_options_wuconstrTbl %>% pull(`Activity Type`) %>% unique),
                     selectizeInput(ns("wuconstr_add_col2"), label = "Water Use", choices = c("Water Use - UK Average")),
                     numericInput(ns("wuconstr_add_col3"), label = "Quantity", value = 0),
                     selectizeInput(ns("wuconstr_add_col4"), label = "Unit", choices = c("litres")),
                     textInput(ns("wuconstr_add_col5"), label = "Comments"),
                     actionButton(ns("wuconstr_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$wuconstr_add_row_go, {
                   #browser()
                   new_row = data.frame(input$wuconstr_add_col1,
                                        input$wuconstr_add_col2,
                                        input$wuconstr_add_col3,
                                        input$wuconstr_add_col4,
                                        "Activity tCO2e" = 0,
                                        input$wuconstr_add_col5
                                        ) %>%
                     dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("input.wuconstr_add_col2" = "Water")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.wuconstr_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   wuconstrvalues$data <- data.table(rbind(wuconstrvalues$data, new_row, use.names = F))

                   sum_cwuse_tCO2$data <- sum(na.omit(as.numeric(wuconstrvalues$data$`Activity tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$wuconstrTblResave = wuconstrvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$wuconstr_Del_row_head,{
                   showModal(
                     if(length(input$wuconstrTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$wuconstrTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("wuconstr_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wuconstr_del_row_ok, {
                   #browser()
                   wuconstrvalues$data=wuconstrvalues$data[-input$wuconstrTbl_rows_selected,]
                   
                   sum_cwuse_tCO2$data <- sum(na.omit(as.numeric(wuconstrvalues$data$`Activity tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$wuconstrTblResave = wuconstrvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$wuconstr_mod_row_head,{
                   showModal(
                     if(length(input$wuconstrTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",

                         selectizeInput(ns("wuconstr_mod_col1"), label = "Activity Type", choices = dropdown_options_wuconstrTbl %>% pull(`Activity Type`) %>% unique),
                         selectizeInput(ns("wuconstr_mod_col2"), label = "Water Use", choices = c("Water Use - UK Average")),
                         numericInput(ns("wuconstr_mod_col3"), label = "Quantity", value = wuconstrvalues$data[input$wuconstrTbl_rows_selected,3]),
                         selectizeInput(ns("wuconstr_mod_col4"), label = "Unit", choices = c("litres")),
                         textInput(ns("wuconstr_mod_col5"), label = "Comments", value = wuconstrvalues$data[input$wuconstrTbl_rows_selected, 6]),

                         hidden(numericInput(ns("wuconstr_mod_rown"), value = input$wuconstrTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("wuconstr_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wuconstr_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$wuconstr_mod_col1,
                                        input$wuconstr_mod_col2,
                                        input$wuconstr_mod_col3,
                                        input$wuconstr_mod_col4,
                                        "Activity tCO2e" = 0,
                                        input$wuconstr_mod_col5
                                        ) %>%
                     dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("input.wuconstr_mod_col2" = "Water")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.wuconstr_mod_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   wuconstrvalues$data[input$wuconstr_mod_rown,] <- new_row
                   
                   sum_cwuse_tCO2$data <- sum(na.omit(as.numeric(wuconstrvalues$data$`Activity tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$wuconstrTblResave = wuconstrvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$wuconstr_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Construction_Water.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Construction_Water.xlsx",to = file)}
                 )
                 
                 observeEvent(input$wuconstr_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$wuconstr_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(wuconstrvalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     templateIn_data <- bind_rows(wuconstrvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("Water Use" = "Water")) %>%
                       dplyr::mutate(`Activity tCO2e` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Quantity > 0)
                     
                     wuconstrvalues$data <- templateIn_data
                     sum_cwuse_tCO2$data <- sum(na.omit(as.numeric(wuconstrvalues$data$`Activity tCO2e`)))
                     
                     sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                     sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                     const_returned$data$Value = const_returned_react()
                     const_returned$wuconstrTblResave = wuconstrvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })

##################### RENDER WORKER TRAVEL TABLE ####
                 
                 output$wtconstrTbl <- DT::renderDT({
                   DT = worktravelconstrvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(2,3), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$wtconstr_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("wtconstr_add_col1"), label = "Mode of Transport", choices = dropdown_options_worktravelconstrTbl %>% pull(Vehicle) %>% unique),
                     numericInput(ns("wtconstr_add_col2"), label = "Total distance travelled by workers during construction (km)", value = 0),
                     textInput(ns("wtconstr_add_col3"), label = "Comments"),
                     actionButton(ns("wtconstr_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$wtconstr_add_row_go, {
                   #browser()
                   new_row = data.frame(input$wtconstr_add_col1,
                                        input$wtconstr_add_col2,
                                        "Transport tCO2e" = 0,
                                        input$wtconstr_add_col3
                   ) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.wtconstr_add_col1" = "Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.wtconstr_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   worktravelconstrvalues$data <- data.table(rbind(worktravelconstrvalues$data, new_row, use.names = F))
                   
                   sum_wtcv_tCO2$data <- sum(na.omit(as.numeric(worktravelconstrvalues$data$`Transport tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$worktravelconstrTblResave = worktravelconstrvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(input$wtconstr_Del_row_head,{
                   showModal(
                     if(length(input$wtconstrTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$wtconstrTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("wtconstr_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wtconstr_del_row_ok, {
                   #browser()
                   worktravelconstrvalues$data=worktravelconstrvalues$data[-input$wtconstrTbl_rows_selected,]
                   
                   sum_wtcv_tCO2$data <- sum(na.omit(as.numeric(worktravelconstrvalues$data$`Transport tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$worktravelconstrTblResave = worktravelconstrvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$wtconstr_mod_row_head,{
                   showModal(
                     if(length(input$wtconstrTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         selectizeInput(ns("wtconstr_mod_col1"), label = "Mode of Transport", choices = dropdown_options_worktravelconstrTbl %>% pull(Vehicle) %>% unique, 
                                        selected = worktravelconstrvalues$data[input$wtconstrTbl_rows_selected, 1]),
                         numericInput(ns("wtconstr_mod_col2"), label = "Total distance travelled by workers during construction (km)",
                                      value = worktravelconstrvalues$data[input$wtconstrTbl_rows_selected, 2]),
                         textInput(ns("wtconstr_mod_col3"), label = "Comments", value = worktravelconstrvalues$data[input$wtconstrTbl_rows_selected, 4]),
                         hidden(numericInput(ns("wtconstr_mod_rown"), value = input$wtconstrTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("wtconstr_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wtconstr_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$wtconstr_mod_col1,
                                        input$wtconstr_mod_col2,
                                        "Transport tCO2e" = 0,
                                        input$wtconstr_mod_col3
                   ) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.wtconstr_mod_col1" = "Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.wtconstr_mod_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   worktravelconstrvalues$data[input$wtconstr_mod_rown,] <- new_row

                   sum_wtcv_tCO2$data <- sum(na.omit(as.numeric(worktravelconstrvalues$data$`Transport tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$worktravelconstrTblResave = worktravelconstrvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$wtconstr_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Construction_WorkerTravel.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Construction_WorkerTravel.xlsx",to = file)}
                 )
                 
                 observeEvent(input$wtconstr_Template_upload$name, {
                   #browser()
                   templateIn <- readxl::read_xlsx(input$wtconstr_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:2], names(worktravelconstrvalues$data)[1:2])){
                     
                     templateIn_data <- bind_rows(worktravelconstrvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("Mode of Transport" = "Vehicle")) %>%
                       dplyr::mutate(`Transport tCO2e` = `Total distance travelled by workers during construction (km)` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       filter(`Transport tCO2e` > 0)
                     
                     worktravelconstrvalues$data <- templateIn_data
                     sum_wtcv_tCO2$data <- sum(na.omit(as.numeric(worktravelconstrvalues$data$`Transport tCO2e`)))
                     
                     sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                     sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                     const_returned$data$Value = const_returned_react()
                     const_returned$worktravelconstrTblResave = worktravelconstrvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 #### end of render WORKER TRAVEL TABLE
                 
##################### RENDER CONS WASTE TABLE ####
                 
                 output$constrwasteTbl <- DT::renderDT({
                   DT = constrwastevalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(8,9), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$constrwaste_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("constrwaste_add_col1"), label = "Waste Type", choices = waste_init_options),
                     uiOutput(ns("constrwaste_add_col2_out")),
                     numericInput(ns("constrwaste_add_col3"), label = "Quantity", value = 0),
                     uiOutput(ns("constrwaste_add_col4_out")),
                     selectizeInput(ns("constrwaste_add_col5"), label = "Mode", choices = trans_mode_options$Vehicle),
                     numericInput(ns("constrwaste_add_col6"), label = "Distance", value = 0),
                     uiOutput(ns("constrwaste_add_col7_out")),
                     textInput(ns("constrwaste_add_col8"), label = "Comments"),
                     actionButton(ns("constrwaste_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$constrwaste_add_row_go, {
                   #browser()
                   new_row = data.frame(input$constrwaste_add_col1,
                                        input$constrwaste_add_col2,
                                        input$constrwaste_add_col3,
                                        input$constrwaste_add_col4,
                                        input$constrwaste_add_col5,
                                        input$constrwaste_add_col6,
                                        input$constrwaste_add_col7,
                                        "Waste Processing Carbon tCO2e" = 0,
                                        "Transport tCO2e" = 0,
                                        input$constrwaste_add_col8) %>%
                     dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                      by = c("input.constrwaste_add_col1"="Waste Type", "input.constrwaste_add_col2"="Waste Route")) %>%
                     dplyr::mutate(`Waste.Processing.Carbon.tCO2e` = input.constrwaste_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.constrwaste_add_col5"="Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.constrwaste_add_col6 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   constrwastevalues$data <- data.table(rbind(constrwastevalues$data, new_row, use.names = F))
                   
                   sum_cwaste_tCO2$data <- sum(na.omit(as.numeric(constrwastevalues$data$`Waste Processing Carbon tCO2e`)))
                   sum_cwaste_trans_tCO2$data <- sum(na.omit(as.numeric(constrwastevalues$data$`Transport tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrwasteTblResave = constrwastevalues$data
                   
                   removeModal()
                 })
                 
                 output$constrwaste_add_col2_out <- renderUI({
                   selectizeInput(ns("constrwaste_add_col2"), label = "Waste Route", choices = constrwaste_wasteroute_choices())
                 })
                 
                 constrwaste_wasteroute_choices <- reactive({
                   wasteroute_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$constrwaste_add_col1) %>%
                     select(`Waste Route`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$constrwaste_add_col4_out <- renderUI({
                   selectizeInput(ns("constrwaste_add_col4"), label = "Unit", choices = constrwaste_unit_choices())
                 })
                 
                 constrwaste_unit_choices <- reactive({
                   unit_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$constrwaste_add_col1) %>%
                     filter(`Waste Route` == input$constrwaste_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$constrwaste_add_col7_out <- renderUI({
                   selectizeInput(ns("constrwaste_add_col7"), label = "Distance Unit", choices = constrwaste_distunit_choices())
                 })
                 
                 constrwaste_distunit_choices <- reactive({
                   unit_options <- efs$Vehicle %>% 
                     filter(`Vehicle` == input$constrwaste_add_col5) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 
                 
                 observeEvent(input$constrwaste_Del_row_head,{
                   showModal(
                     if(length(input$constrwasteTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$constrwasteTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("constrwaste_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$constrwaste_del_row_ok, {
                   
                   constrwastevalues$data=constrwastevalues$data[-input$constrwasteTbl_rows_selected,]
                   const_returned$constrwasteTblResave = constrwastevalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$constrwaste_mod_row_head,{
                   showModal(
                     if(length(input$constrwasteTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("constrwaste_mod_col1"), label = "Waste Type", choices = waste_init_options),
                         uiOutput(ns("constrwaste_mod_col2_out")),
                         numericInput(ns("constrwaste_mod_col3"), label = "Quantity", value = constrwastevalues$data[input$constrwasteTbl_rows_selected, 3]),
                         uiOutput(ns("constrwaste_mod_col4_out")),
                         selectizeInput(ns("constrwaste_mod_col5"), label = "Mode", choices = trans_mode_options$Vehicle),
                         numericInput(ns("constrwaste_mod_col6"), label = "Distance", value = constrwastevalues$data[input$constrwasteTbl_rows_selected, 6]),
                         uiOutput(ns("constrwaste_mod_col7_out")),
                         textInput(ns("constrwaste_mod_col8"), label = "Comments", value = constrwastevalues$data[input$constrwasteTbl_rows_selected, 10]),
                         
                         hidden(numericInput(ns("constrwaste_mod_rown"), value = input$constrwasteTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("constrwaste_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$constrwaste_mod_col2_out <- renderUI({
                   selectizeInput(ns("constrwaste_mod_col2"), label = "Waste Route", choices = constrwaste_wasteroute_choices_mod())
                 })
                 
                 constrwaste_wasteroute_choices_mod <- reactive({
                   wasteroute_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$constrwaste_mod_col1) %>%
                     select(`Waste Route`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$constrwaste_mod_col4_out <- renderUI({
                   selectizeInput(ns("constrwaste_mod_col4"), label = "Unit", choices = constrwaste_unit_choices_mod())
                 })
                 
                 constrwaste_unit_choices_mod <- reactive({
                   unit_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$constrwaste_mod_col1) %>%
                     filter(`Waste Route` == input$constrwaste_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$constrwaste_mod_col7_out <- renderUI({
                   selectizeInput(ns("constrwaste_mod_col7"), label = "Distance Unit", choices = constrwaste_distunit_choices_mod())
                 })
                 
                 constrwaste_distunit_choices_mod <- reactive({
                   unit_options <- efs$Vehicle %>% 
                     filter(`Vehicle` == input$constrwaste_mod_col5) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$constrwaste_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$constrwaste_mod_col1,
                                        input$constrwaste_mod_col2,
                                        input$constrwaste_mod_col3,
                                        input$constrwaste_mod_col4,
                                        input$constrwaste_mod_col5,
                                        input$constrwaste_mod_col6,
                                        input$constrwaste_mod_col7,
                                        "Waste Processing Carbon tCO2e" = 0,
                                        "Transport tCO2e" = 0,
                                        input$constrwaste_mod_col8) %>%
                     dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                      by = c("input.constrwaste_mod_col1"="Waste Type", "input.constrwaste_mod_col2"="Waste Route")) %>%
                     dplyr::mutate(`Waste.Processing.Carbon.tCO2e` = input.constrwaste_mod_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.constrwaste_mod_col5"="Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.constrwaste_mod_col6 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   constrwastevalues$data[input$constrwaste_mod_rown,] <- new_row
                   
                   sum_cwaste_tCO2$data <- sum(na.omit(as.numeric(constrwastevalues$data$`Waste Processing Carbon tCO2e`)))
                   sum_cwaste_trans_tCO2$data <- sum(na.omit(as.numeric(constrwastevalues$data$`Transport tCO2e`)))
                   
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   
                   const_returned$data$Value = const_returned_react()
                   const_returned$constrwasteTblResave = constrwastevalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$constrwaste_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Construction_Waste.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Construction_Waste.xlsx",to = file)}
                 )
                 
                 observeEvent(input$constrwaste_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$constrwaste_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:5], names(constrwastevalues$data)[1:5])){
                     
                     if (typeof(templateIn$Quantity) == "character" | typeof(templateIn$Distance) == "character"){
                       templateIn$Quantity <- as.numeric(templateIn$Quantity)
                       templateIn$Distance <- as.numeric(templateIn$Distance)
                     }
                     
                     templateIn_data <- bind_rows(constrwastevalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                        by = c("Waste Type"="Waste Type", "Waste Route"="Waste Route")) %>%
                       dplyr::mutate(`Waste Processing Carbon tCO2e` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("Transport Mode"="Vehicle")) %>%
                       dplyr::mutate(`Transport tCO2e` = Distance * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Quantity` > 0)
                     
                     constrwastevalues$data <- templateIn_data
                     
                     sum_cwaste_tCO2$data <- sum(na.omit(as.numeric(constrwastevalues$data$`Waste Processing Carbon tCO2e`)))
                     sum_cwaste_trans_tCO2$data <- sum(na.omit(as.numeric(constrwastevalues$data$`Transport tCO2e`)))
                     
                     sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                     sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                     
                     const_returned$data$Value = const_returned_react()
                     const_returned$constrwasteTblResave = constrwastevalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
#################### RENDER CARBON SAVINGS TABLES ####                 
                 
                 # Carbon saving options (non-implementation) ----
                 output$csavoNoImplTbl <- DT::renderDT({
                   DT = csavoNoImplvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$csavoN_Add_row_head, {
                   showModal(modalDialog(
                     title = "Add a new row",
                     textInput(ns("csavoN_add_col1"), label = "Description of options and how they will lead to carbon savings"),
                     textInput(ns("csavoN_add_col2"), label = "Rationale for why the option has not been taken forward for implementation"),
                     actionButton(ns("csavoN_Add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$csavoN_Add_row_go, {
                   new_row = data.frame(input$csavoN_add_col1, input$csavoN_add_col2)
                   csavoNoImplvalues$data <- data.table(rbind(csavoNoImplvalues$data, new_row, use.names = F))
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   const_returned$carbsavenotimp <- tmpdf
                   const_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_Del_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoNoImplTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("csavoN_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoN_del_row_ok, {
                   csavoNoImplvalues$data = csavoNoImplvalues$data[-input$csavoNoImplTbl_rows_selected,]
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   const_returned$carbsavenotimp <- tmpdf
                   const_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_mod_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         textInput(ns("csavoN_mod_col1"), label = "Description of options and how they will lead to carbon savings", value = csavoNoImplvalues$data[input$csavoNoImplTbl_rows_selected,1]),
                         textInput(ns("csavoN_mod_col2"), label = "Rationale for why the option has not been taken forward for implementation", value = csavoNoImplvalues$data[input$csavoNoImplTbl_rows_selected,2]),
                         hidden(numericInput(ns("csavoN_mod_rown"), value = input$csavoNoImplTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("csavoN_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoN_confirm_mod, {
                   new_row = data.frame(input$csavoN_mod_col1, input$csavoN_mod_col2)
                   csavoNoImplvalues$data[input$csavoN_mod_rown,] <- new_row
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   const_returned$carbsavenotimp <- tmpdf
                   const_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 
                 # Carbon saving options (Implementation) ----
                 output$csavoImplTbl <- DT::renderDT({
                   DT = csavoImplvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$csavoI_Add_row_head, {
                   showModal(modalDialog(
                     title = "Add a new row",
                     textInput(ns("csavoI_add_col1"), label = "Description of options and how they will lead to carbon savings"),
                     textInput(ns("csavoI_add_col2"), label = "Rationale for implementation"),
                     actionButton(ns("csavoI_Add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$csavoI_Add_row_go, {
                   new_row = data.frame(input$csavoI_add_col1, input$csavoI_add_col2)
                   csavoImplvalues$data <- data.table(rbind(csavoImplvalues$data, new_row, use.names = F))
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   const_returned$carbsaveimp <- tmpdf
                   const_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_Del_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoImplTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("csavoI_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoI_del_row_ok, {
                   csavoImplvalues$data = csavoImplvalues$data[-input$csavoImplTbl_rows_selected,]
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   const_returned$carbsaveimp <- tmpdf
                   const_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_mod_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         textInput(ns("csavoI_mod_col1"), label = "Description of options and how they will lead to carbon savings", value = csavoImplvalues$data[input$csavoImplTbl_rows_selected,1]),
                         textInput(ns("csavoI_mod_col2"), label = "Rationale for why the option has not been taken forward for implementation", value = csavoImplvalues$data[input$csavoImplTbl_rows_selected,2]),
                         hidden(numericInput(ns("csavoI_mod_rown"), value = input$csavoImplTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("csavoI_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoI_confirm_mod, {
                   new_row = data.frame(input$csavoI_mod_col1, input$csavoI_mod_col2)
                   csavoImplvalues$data[input$csavoI_mod_rown,] <- new_row
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   const_returned$carbsaveimp <- tmpdf
                   const_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
####################### OBSERVEEVENTS CONTROLLING UI ELEM VISIBILITY #### 
                 
                 #################### OBSERVEEVENT FOR CHECKBOX INPUT CHANGES ######################
                 observeEvent(input$constrwasteToggle, {
                   #
                   shinyjs::toggle("constrwasteTbl_box", condition = !(input$constrwasteToggle))
                   shinyjs::toggle("constrwasteProjSize_box", condition = input$constrwasteToggle)

                   if (input$constrwasteToggle == TRUE){ # reset detailed const table and sums to zero if checkbox = TRUE
                     constrwastevalues$data = DF_constrwaste
                     sum_cwaste_tCO2$data = 0.0
                     sum_cwaste_trans_tCO2$data = 0.0
                   } else {  # reset simple const table and sums to zero if checkbox = FALSE
                     shinyWidgets::updateAutonumericInput(session = session, inputId = "constCost", value = 0)
                   }
                    sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                    sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                    const_returned$data$Value = const_returned_react()
                 })
                 
                 # OBSERVE EVENT FOR CHANGES TO CONSTRUCTION COST FIELD
                 observeEvent(input$constCost, {
                   sum_totalconst_tCO2$data <- sum_totalconst_tCO2_react()
                   sum_totalconst_waste_tCO2$data <- sum_totalconst_waste_tCO2_react()
                   const_returned$data$Value = const_returned_react()
                 })
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
                 
                 
               }, session = getDefaultReactiveDomain()
			   )
  
  return(const_returned)
  
}

##### Embodied Carbon submodule ##############################################################################################################

# Last modified by Andy Brown (11/01/2022)
# - AT (21/09/2021):  Added Raw Materials Embodied Carbon rHandsontable
#                     Added guidance notes toggle section
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory
# - HC (08/08/2024):  updates to embcarbon_server to pass in efs_react, efs_materialroad_userinput, efs_materialrail_userinput as objects rather than global vars

################################################################################################################

embcarbon_ui <- function(id,tabName){
  ns <- NS(id)
  
  # initial choices for road or rail material dropdown options
  if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
    material_choices <- data.table(efs$Material_Road)
  } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
    material_choices <- data.table(efs$Material_Rail)
  } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
    material_choices <- data.table(efs$Material_Road)
  }
  
  
  tabItem(
    tabName = tabName,
    box(width = 12,
        fluidRow(
          column(width = 7,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), emb_carbon_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 5, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 h6(HTML("<br>")),
                 h4(tagList(eflibrary_icon, "Total Embodied Carbon Emissions (tCO2e):  ", textOutput(outputId = ns("sum_totalembcarbon_tCO2"), inline = T), 
                            HTML("&nbsp;"), HTML("&nbsp;")))
          )
        ),
        
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            hidden(
                            div(id = ns("guid_notes"),
                                p(HTML("<br> </br>The <b>Before Use - Embodied Carbon Stage</b> considers the product stage, including materials that will be used during the construction process, their life time (to determine replacement cycles) and details of material transportation. <br><br>
                   Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                   The data input table requires:<br>
                   <ul><li> Drop-down selection of the material category (e.g. concrete pavements, kerbs, ancillaries)</li>
                   <li> Drop-down selection of the material sub category</li>
                   <li> the material type to be selected </li></ul><br>
                   The <b>Material Groups Comparison</b> tab allows the comparison of CO<sub>2</sub> emission factors between different materials within the same material group, and also between two different material groups on the left and right hand sides of the page.
                   Select the material group from the upper dropdown menu, then select one or multiple materials in the lower dropdown menu to compare.<br><br>
                   To use a material and known emission factor that is not in the list, click on the <b>Add material</b> tab and enter all of the information requested, taking care to use the correct units (carbon should always be in kgCO2e). The same method should be used to add carbon factor data for new materials or components from EPDs.
                   A default percentage of material to be used during maintenance in the project lifetime will be auto populated, this is based on standard assumptions. There is now the option to use a custom maintenance value instead of the default - this can be activated by ticking the relevant checkbox and populating the custom maintenance value.
                   and cannot be changed. Note that the Default Maintenance Percentage may be greater than 100% where all materials are completely replaced more than once during the project lifetime.<br><br>
                   For transport of material, the mode of transport and estimated kilometres travelled for each material is required. Two modes of transport can be entered per material.
                   Emissions are calculated automatically as data is entered.<br>
                   Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each material detailed, as applicable."))
                            ))))),
        #hr(),
        
        # Raw materials tab -----
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "rmec",
               tabPanel(title = tagList("Raw Materials Embodied Carbon", icon("arrow-circle-right")), value = "rmec",
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="This includes emissions from maintenance of materials over the scheme design life",
                                          h4("Raw Materials Embodied Carbon Emissions (tCO2e):  ", textOutput(outputId = ns("sum_embcarbon_tCO2"), inline = T), tags$sup(icon("question-circle"))) #HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 
                                 h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime1"), inline = T)),
                                 br(),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("rmec_add_n_rows"), label = NULL, value = 5, min = 1, max = 20), 
                                 #        actionButton(inputId = ns("rmec_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("rmecTbl")),
                                 # tags$style(HTML(rhandsontable_headstyle)),
                                 # p("* Additional rows can be added to the table by right-clicking on the table")
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("rmecTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("EmbCarb_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;", 
                                         fileInput2(inputId = ns("EmbCarb_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F)),
                                 valueBoxOutput(ns("rmec_ro_Tbl_textheader"), width = 12),
                                 dataTableOutput(ns("rmec_ro_Tbl"))
                          )
                        ),
                        
                        # fluidRow(
                        #   column(width = 12,
                        #          h4("Raw Materials Embodied Carbon - Legacy Emission Factors"),
                        #   h5("Please update to new emission factors in the table above"),
                        #   tableOutput(ns("rmecTbl_readonly"))
                        #   )
                        # )
               ),
               
               # Transport tab -----
               tabPanel(title = tagList("Transport", icon("arrow-circle-right")), value = "trans",
                        fluidRow(
                          column(width = 12,
                                 # tags$div(title="This includes emissions from maintenance of materials over the scheme design life",
                                 h4("Transport of Raw Materials Emissions (tCO2e):  ", textOutput(outputId = ns("sum_trans_tCO2"), inline = T)),
                                 HTML("<br> </br>"),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("tran_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("tran_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("transTbl")),
                                 # tags$style(HTML(rhandsontable_headstyle)),
                                 # ),
                                 # h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime1"), inline = T)),
                                 # rHandsontableOutput(ns("rmecTbl")),
                                 # tags$style(HTML(rhandsontable_headstyle)),
                                 # p("* Additional rows can be added to the table by right-clicking on the table")
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("trans_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("trans_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("trans_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),

                                 column(12,
                                        DT::DTOutput(ns("transTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("EmbCarb_Trans_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("EmbCarb_Trans_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
                          )
                        )
               ),
               
               # Carbon saving and new materials -----
               tabPanel(title = tagList("Carbon Saving Opportunities", icon("check-circle")), value = "csavo",
                        fluidRow(
                          column(width = 12,
                                 h4(strong("Carbon Savings Identified but not Implemented")),
                                 #rHandsontableOutput(ns("csavoNoImplTbl")),
                                 #tags$style(type="text/css", paste0("#",ns("csavoNoImplTbl"), rhandsontable_headstyle))
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
                                 #rHandsontableOutput(ns("csavoImplTbl")),
                                 #tags$style(type="text/css", paste0("#",ns("csavoImplTbl"), rhandsontable_headstyle))
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
               ),
               
               # Comparison groups tab -----
               tabPanel(title = tagList("Material Groups Comparison", icon("info-circle")), value = "comp",
                        fluidRow(
                          column(width = 12,
                                 h5(HTML("<br>In addition to material substitutions, design modifications can deliver significant 
                                         carbon savings and should be evaluated during project design. Examples include: <br>
                                         <ul><li>Combine structural elements (e.g. tunnel linings and track beds) to reduce material use</li>
                                         <li>Optimise pile design to minimise concrete and steel use</li>
                                         <li>Adopt pre-cast or modular construction (e.g. twin arch tunnel linings)</li></ul>"))
                                 )
                          ),
                        fluidRow(
                          column(width = 4,
                                 # tags$div(title="This includes emissions from maintenance of materials over the scheme design life",
                                 #h4("Transport of Raw Materials Emissions (tCO2e):  ", textOutput(outputId = ns("sum_trans_tCO2"), inline = T)),
                                 HTML("<br> </br>"),
                                 selectizeInput(ns("comparisongroupleft"), label = "Select Material Group for Comparison", 
                                                choices = c("In-Situ Concrete","Pre-cast concrete block","Concrete block walls","Other pre-cast concrete",
                                                            "Concrete Piles","Cement","Paving Slabs","Plastic Pipework","Kerbs and Edging","Asphalt",
                                                            "Aggregates","Steel","Lighting and Signage Columns"))
                          ),
                          column(width = 2),
                          column(width = 4,
                                 HTML("<br> </br>"),
                                 selectizeInput(ns("comparisongroupright"), label = "Select Material Group for Comparison", 
                                                choices = c("In-Situ Concrete","Pre-cast concrete block","Concrete block walls","Other pre-cast concrete",
                                                            "Concrete Piles","Cement","Paving Slabs","Plastic Pipework","Kerbs and Edging","Asphalt",
                                                            "Aggregates","Steel","Lighting and Signage Columns"))
                          )
                        ),
                        fluidRow(
                          column(width = 5,
                                 HTML("<br> </br>"),
                                 selectizeInput(ns("comparisonleft"), label = "Comparison Material", choices = NULL, selected="Please select...", multiple=TRUE),
                                 DT::DTOutput(ns("compTblleft"))
                          ),
                          column(width = 1),
                          column(width = 5,
                                 HTML("<br> </br>"),
                                 selectizeInput(ns("comparisonright"), label = "Comparison Material", choices = NULL, selected="Please select...", multiple=TRUE),
                                 DT::DTOutput(ns("compTblright"))
                          )
                        )
               ),
               
               tabPanel(title = tagList(addcustom_icon, " Add New Material"), value = "addnew",
                        fluidRow(
                          column(width = 6,
                                 
                                 p(HTML("Please select from the dropdown menus and populate all fields, then click 'Add New Material'.")),
                                 
                                 hr(),
                                 
                                 # Form input fields
                                 
                                 selectInput(ns("new_material_category"), label = "Enter Material Category",
                                             choices = unique(material_choices$Category), selected = unique(material_choices$Category)[1], multiple = F),
                                 
                                 selectInput(ns("new_material_subcategory"), label = "Enter Material Sub-Category",
                                             choices = unique(material_choices$`Sub Category`), selected = unique(material_choices$`Sub Category`)[1], multiple = F),
                                 
                                 textInput(ns("new_material_name"), "Enter Material Name", value = ""),
                                 
                                 fluidRow(
                                   column(width = 6,
                                          numericInput(ns("new_material_kgCO2e"), label = "Enter kgCO2e per unit", value = NULL, min = 0, max = 1000000),
                                   ),
                                   
                                   column(width = 6,
                                          selectInput(ns("new_material_unit"), label = "Units",
                                                      choices = unique(material_choices$Unit), selected = unique(material_choices$Unit)[1], multiple = F)
                                          
                                          
                                          
                                   )
                                 ),
                                 
                                 textInput(ns("new_material_reference"), "Enter Material Reference"),
                                 
                                 hr(),
                                 
                                 actionButton(inputId = ns("addnewbutton"), label = "Add Material", style=toggle_guid_btn_style),
                                 
                          )
                        )
               )
        )
    )
  )
}



embcarbon_server <- function(id, option_number, thetitle, theoutput, appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput){
  
   
  # Switch selection depending on Road or Rail Option
  if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
    dropdown_options <- efs$Material_Road %>%
      select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
      dplyr::left_join(., efs$Flag_Text, by = c("Category" = "Category", "Sub Category" = "Sub Category", "Material" = "Material")) %>%
      as.data.table()
    template_filename <- "Road_Embodied_Carbon.xlsx"
    template_filepath <- "Templates/Road_Embodied_Carbon.xlsx"
  } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
    dropdown_options <- efs$Material_Rail %>%
      select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
      dplyr::left_join(., efs$Flag_Text, by = c("Category" = "Category", "Sub Category" = "Sub Category", "Material" = "Material")) %>%
      as.data.table()
    template_filename <- "Rail_Embodied_Carbon.xlsx"
    template_filepath <- "Templates/Rail_Embodied_Carbon.xlsx"
  } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
    dropdown_options <- efs$Material_Road %>%
      select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
      dplyr::left_join(., efs$Flag_Text, by = c("Category" = "Category", "Sub Category" = "Sub Category", "Material" = "Material")) %>%
      as.data.table()
    template_filename <- "Road_Embodied_Carbon.xlsx"
    template_filepath <- "Templates/Road_Embodied_Carbon.xlsx"
  } else {
    print("No matching data")
  }

  dropdown_options_react <- reactiveValues(data=dropdown_options)
  
  trans_mode_options <- efs$Vehicle %>%
    filter(Category %in% "Freight Vehicles") %>%
    filter(Unit %in% "km") # just select options where emission factor is in kgCO2e / km travelled
  
  ### Initial values for DF_rmec df
  cat_init <- dropdown_options %>% pull(Category) %>% unique
  
  # generate conversion factors from hectare (default) to other area units
  area_conversion <- data.table(c("ha", "m2","km2","mi2"))[, V2 := c(1,0.0001,100,258.9989174)]
  names(area_conversion) <- c("unit","conv_factor")
  
  # definition of data.table for RMEC table
  # DF_rmec = data.table(Category = rep(cat_init[1],rhot_rows), 
  #                      `Sub Category` = as.character(NA), 
  #                      Material = as.character(NA),
  #                      Quantity = 0.0,
  #                      Unit = as.character(NA),
  #                      `Default Maintenance Percentage` = 0.0,
  #                      `Transport Mode 1` = as.character(NA),
  #                      `Distance Mode 1` = 0.0,
  #                      `Distance Unit Mode 1` = as.character(NA),
  #                      `Transport Mode 2` = as.character(NA),
  #                      `Distance Mode 2` = 0.0,
  #                      `Distance Unit Mode 2` = as.character(NA),
  #                      `Embodied tCO2e` = 0.0,
  #                      `Maintenance tCO2e` = 0.0,
  #                      `Transport tCO2e` = 0.0,
  #                      Comments = as.character(NA),
  #                      stringsAsFactors = F, check.names = FALSE)
  DF_rmec = data.table(Category = rep(cat_init[1],rhot_rows), 
                       `Sub Category` = as.character(NA), 
                       Material = as.character(NA),
                       Quantity = 0.0,
                       Unit = as.character(NA),
                       `Default Maintenance Percentage` = 0.0,
                       `Embodied tCO2e` = 0.0,
                       `Maintenance tCO2e` = 0.0,
                       Comments = as.character(NA),
                       `Custom Maintenance` = "N",
                       stringsAsFactors = F, check.names = FALSE)
  
  
  DF_trans = data.table(`Transport Type` = rep("HGV - All - Average", rhot_rows), 
                        Distance = 0.0,
                        Unit = "km",
                        `Transport tCO2e` = 0.0,
                        Comments = as.character(NA),
                        stringsAsFactors = F, check.names = FALSE)
  
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                              `Rationale for why the option has not been taken forward for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                            `Rationale for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  
  rmecvalues <- reactiveValues(data=DF_rmec)
  transvalues <- reactiveValues(data=DF_trans)
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  rmec_readonly_values <- reactiveValues(data=DF_rmec)
  
  # reactiveValues for summary embodied carbon detailed split table
  emb_carbon_summaryDT <- reactiveValues(data=data.table(Category = c("",""), `Embodied tCO2e` = c(0.0, 0.0)))
  
  
  
  sum_emb_tCO2 <- reactiveValues(data=0.0)
  sum_maint_tCO2 <- reactiveValues(data=0.0)
  sum_trans_tCO2 <- reactiveValues(data=0.0)
  
  sum_embcarbon_tCO2 <- reactiveValues(data=0.0)
  
  
  DF_returned <- data.table(Option = c(option_number, option_number, option_number, option_number),
                            Stage = c("Embodied Carbon","Embodied Carbon","Embodied Carbon","Embodied Carbon"),
                            Measure = c("Embodied","Maintenance","Transport","Total"),
                            Value = c(0.0,0.0,0.0,0.0),
                            stringsAsFactors = F, check.names = FALSE)
  
  embcarbon_returned <- reactiveValues(data=DF_returned,
                                       details=data.table(Option = c("",""), Category = c("",""), `Embodied tCO2e` = c(0.0, 0.0)),
                                       carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                                 Stage = c("Embodied Carbon"),
                                                                 Description = c(""), Rationale = c("")),
                                       carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                              Stage = c("Embodied Carbon"),
                                                              Description = c(""), Rationale = c("")),
                                       rmecTblResave = DF_rmec,
                                       transTblResave = DF_trans,
                                       csavoNoImplTblResave = DF_csavoNoImpl,
                                       csavoImplTblResave = DF_csavoImpl)                                      
  
  
  moduleServer(id,
               function(input, output, session){
                 
                 ns <- session$ns
                 
                 comparison_group_options_left <- reactive({
                   tmp <- efs$Comparison_Groups %>%
                     dplyr::filter(Group %like% input$comparisongroupleft) %>%
                     dplyr::select(Material) %>% distinct()
                   options <- sort(tmp$Material)
                 })
                 
                 comparison_group_options_right <- reactive({
                   tmp <- efs$Comparison_Groups %>%
                     dplyr::filter(Group %like% input$comparisongroupright) %>%
                     dplyr::select(Material) %>% distinct()
                   options <- sort(tmp$Material)
                 })
                 
                 #updateSelectizeInput(session, "comparison", choices = dropdown_options$Material, server = TRUE)
                 observeEvent(input$comparisongroupleft, {
                   updateSelectizeInput(session, "comparisonleft", choices = NULL, server = TRUE, selected = "Please select...")
                   updateSelectizeInput(session, "comparisonleft", choices = comparison_group_options_left(), server = TRUE, selected = "Please select...")
                 })
                 # observeEvent(input$comparison, {
                 #   updateSelectizeInput(session, "comparison1", choices = NULL, server = TRUE, selected = "Please select...")
                 #   updateSelectizeInput(session, "comparison2", choices = NULL, server = TRUE, selected = "Please select...")
                 # })
                 
                 observeEvent(input$comparisongroupright, {
                   updateSelectizeInput(session, "comparisonright", choices = NULL, server = TRUE, selected = "Please select...")
                   updateSelectizeInput(session, "comparisonright", choices = comparison_group_options_right(), server = TRUE, selected = "Please select...")
                 })
                 
                 output$compTblleft <- DT::renderDT({
                   DT <- efs$Comparison_Groups %>%
                     dplyr::filter(Material %in% input$comparisonleft) %>%
                     select(Material, Unit, `kgCO2e/unit`) %>% distinct()
                   datatable(DT, options = list(dom = 't'), escape=F, rownames= FALSE)
                 })
                 
                 output$compTblright <- DT::renderDT({
                   DT <- efs$Comparison_Groups %>%
                     dplyr::filter(Material %in% input$comparisonright) %>%
                     select(Material, Unit, `kgCO2e/unit`) %>% distinct()
                   datatable(DT, options = list(dom = 't'), escape=F, rownames= FALSE)
                 })
                 
                 
                 
                 output$some_title <- renderText({thetitle})
                 output$the_ns_id <- renderText({id})
                 
                 output$sum_embcarbon_tCO2 <- renderText({formatC(round(sum(sum_emb_tCO2$data, sum_maint_tCO2$data), digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_totalembcarbon_tCO2 <- renderText({formatC(round(sum_embcarbon_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_trans_tCO2 <- renderText({formatC(round(sum_trans_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 #embcarb_lifetime_react <- reactive(projectdetails_values$lifeTime)
                 output$lifeTime1 <- reactive({projectdetails_values$lifeTime})
                 
                 
                 # update dropdown options based on efs_react
                 observe({
                   # Switch selection depending on Road or Rail Option
                   #if (id == "embcarbonro1"){browser()}
                   if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
                     dropdown_options_react$data <- efs_react$data$Material_Road %>% 
                       select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
                       dplyr::left_join(., efs$Flag_Text, by = c("Category" = "Category", "Sub Category" = "Sub Category", "Material" = "Material")) %>%
                       unique(.) %>%
                       as.data.table()
                   } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
                     dropdown_options_react$data <- efs_react$data$Material_Rail %>% 
                       select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
                       dplyr::left_join(., efs$Flag_Text, by = c("Category" = "Category", "Sub Category" = "Sub Category", "Material" = "Material")) %>%
                       unique(.) %>%
                       as.data.table()
                   } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
                     dropdown_options_react$data <- efs_react$data$Material_Road %>% 
                       select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
                       dplyr::left_join(., efs$Flag_Text, by = c("Category" = "Category", "Sub Category" = "Sub Category", "Material" = "Material")) %>%
                       unique(.) %>%
                       as.data.table()
                   } else {
                     print("No matching data")
                   }
                 })
                 
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   EMBCARBON   appR_returned$loadReact")
                   print(id)#; 
                   #if (id == "embcarbonra1"){browser()}
                   ## 
                   rmecvalues$data = DF_rmec
                   transvalues$data = DF_trans
                   csavoNoImplvalues$data = DF_csavoNoImpl
                   csavoImplvalues$data = DF_csavoImpl
                   
                   # read-only values for old save files using legacy EFs
                   rmec_readonly_values$data = DF_rmec
                   
                   sum_emb_tCO2$data = 0.0
                   sum_maint_tCO2$data = 0.0
                   sum_trans_tCO2$data = 0.0
                   
                   sum_embcarbon_tCO2$data = 0.0
                   
                   embcarbon_returned$data$Value = c(0.0,0.0,0.0,0.0)
                   
                   embcarbon_returned$carbsaveimp$Description = c("")
                   embcarbon_returned$carbsaveimp$Rationale = c("")
                   embcarbon_returned$carbsavenotimp$Description = c("")
                   embcarbon_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   #if (id == "embcarbonro1"){browser()}
                   
                   
                   if (is.null(appR_returned$data[[paste0(id,"_rmecTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                     #browser()
                     # Load data from the load file into rhandsontables and reactivevalues
                     
                     if (appR_returned$data$saveVersion < 2 & 
                         sum(appR_returned$data[[paste0(id,"_rmecTbl")]]$Quantity) > 0) {
                       # Send loaded table to read-only datatable output to display the entries relating to the old EF library
                       print("EMBCARBON:  Savefile version NOT up to date - please check inputs")
                       #browser()
                       tmpData <- appR_returned$data[[paste0(id,"_rmecTbl")]]
                       if (ncol(tmpData)==9){tmpData$`Custom Maintenance` <- "N"}
                       colnames(tmpData) <- colnames(DF_rmec)
                       tmpData$Comments <- as.character(tmpData$Comments)
                       tmpData$Unit <- as.character(tmpData$Unit)
                       
                       rmec_readonly_values$data <- tmpData
                       
                       
                       # read-only table
                       # output$rmec_ro_Tbl <- renderDataTable({
                       #   datatable(rmec_readonly_values$data)
                       # })
                       
                       # output$rmec_ro_Tbl_textheader <- renderUI({
                       #   #HTML(h5("Raw Materials Embodied Carbon <strong>READ-ONLY</strong> Reference Table"))
                       #   HTML(h5("Raw Materials Embodied Carbon <strong>READ-ONLY</strong> Reference Table"))
                       # })
                       
                       # struggling to get good results with renderText/renderUI, so have opted for infoBox here...
                       output$rmec_ro_Tbl_textheader <- renderValueBox({  # renderInfoBox({
                         #infoBox("Raw Materials Embodied Carbon READ-ONLY Reference Table", icon = icon("info"))
                         valueBox("READ-ONLY Reference Table", subtitle="", icon=NULL, color="black")
                       })
                       
                       
                       # output$rmec_ro_Tbl <- renderRHandsontable({
                       #   rmecTable <- rhandsontable(rmec_readonly_values$data, rowHeaders = NULL, height = 300)
                       #   rmecTable <- hot_cols(rmecTable,
                       #                         colWidths = c(250, 250, 250, 80, 50, 100, 100, 100, 250),
                       #                         readOnly = TRUE)
                       # })
                       output$rmec_ro_Tbl <- DT::renderDT({
                         DT = rmec_readonly_values$data %>% dplyr::select(-`Custom Maintenance`)
                         datatable(DT, #selection = 'single',
                                   escape=F, rownames= FALSE)
                       })
                       
                       #browser()
                       # display warning popup box for early savefile version - this code block should ensure that the shiny alert is only triggered once
                       # firstly, trigger on road option 1 if there are >0 road options, otherwise if there are zero road options, trigger on rail option 1
                       # if there are >0 rail options, otherwise trigger on greenway option 1
                       #if (id %in% c("embcarbonro1","embcarbonra1","embcarbongw1")){
                       if (appR_returned$num_road_opts_react() > 0 & id == "embcarbonro1"){
                         shinyalert(
                           title = "Warning!",
                           text = "<h3>Early version of savefile loaded<br>(v1 or older)</h3><p>Embodied Carbon Raw Materials values have been 
                           loaded into a <strong>separate</strong> table for reference only. Please update accordingly in main table using the new emission factors.",
                           timer = 0, showConfirmButton = T, animation = F, closeOnEsc = T, immediate = F, html = T, type = "warning")#, inputId = "early_savefile_version")
                       } else if (appR_returned$num_rail_opts_react() > 0 & 
                                  appR_returned$num_road_opts_react() == 0 &
                                  appR_returned$num_greenway_opts_react() == 0 &
                                  id == "embcarbonra1"){
                         shinyalert(
                           title = "Warning!",
                           text = "<h3>Early version of savefile loaded<br>(v1 or older)</h3><p>Embodied Carbon Raw Materials values have been 
                           loaded into a <strong>separate</strong> table for reference only. Please update accordingly in main table using the new emission factors.",
                           timer = 0, showConfirmButton = T, animation = F, closeOnEsc = T, immediate = F, html = T, type = "warning")#, inputId = "early_savefile_version")
                       } else if (appR_returned$num_greenway_opts_react() > 0 & 
                                  appR_returned$num_road_opts_react() == 0 &
                                  appR_returned$num_rail_opts_react() == 0 &
                                  id == "embcarbongw1"){
                         shinyalert(
                           title = "Warning!",
                           text = "<h3>Early version of savefile loaded<br>(v1 or older)</h3><p>Embodied Carbon Raw Materials values have been 
                           loaded into a <strong>separate</strong> table for reference only. Please update accordingly in main table using the new emission factors.",
                           timer = 0, showConfirmButton = T, animation = F, closeOnEsc = T, immediate = F, html = T, type = "warning")#, inputId = "early_savefile_version")
                       }
                       
                     } else {
                       print("EMBCARBON:  Savefile Version 2 - up to date")
                       #if (id == "embcarbonro1"){browser()}
                       #shiny.destroy::removeOutput("rmec_ro_Tbl")
                       output$rmec_ro_Tbl <- NULL
                       output$rmec_ro_Tbl_textheader <- NULL
                       
                       tmpData <- as.data.table(appR_returned$data[[paste0(id,"_rmecTbl")]])
                       if (ncol(tmpData)==9){tmpData$`Custom Maintenance` <- "N"}
                       tmpData[is.na(`Custom Maintenance`), `Custom Maintenance` := "N"] # convert any NAs to "N"
                       colnames(tmpData) <- colnames(DF_rmec)
                       tmpData$Comments <- as.character(tmpData$Comments)
                       tmpData$Unit <- as.character(tmpData$Unit)
                       #tmpData$`Distance Unit Mode 1` <- as.character(tmpData$`Distance Unit Mode 1`)
                       #tmpData$`Distance Unit Mode 2` <- as.character(tmpData$`Distance Unit Mode 2`)
                       #}
                       
                       ## update EF with manual EFs from save file
                       # if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){ # single assign so it doesn't leave the function
                       #   dropdown_options_temp <- rbind(efs$Material_Road, appR_returned$data$efs_materialroad_userinput, use.names = T, fill = T) %>%
                       #     select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
                       #     unique(.) %>%
                       #     as.data.table()
                       # 
                       # } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
                       #   dropdown_options_temp <- rbind(efs$Material_Rail, appR_returned$data$efs_materialrail_userinput, use.names = T, fill = T) %>%
                       #     select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
                       #     unique(.) %>%
                       #     as.data.table()
                       # 
                       # } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
                       #   dropdown_options_temp <- rbind(efs$Material_Road, appR_returned$data$efs_materialroad_userinput, use.names = T, fill = T) %>%
                       #     select(Category, `Sub Category`, Material, Unit, `kgCO2e per unit`, `% replaced in 1 maintenance cycle`, `Regularity of maintenance cycle`) %>%
                       #     unique(.) %>%
                       #     as.data.table()
                       # }
                       
                       
                       if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){ # single assign so it doesn't leave the function
                         dropdown_options_temp <- efs_react$data$Material_Road
                         
                       } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
                         dropdown_options_temp <- efs_react$data$Material_Rail
                         
                       } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
                         dropdown_options_temp <- efs_react$data$Material_Road
                       }
                       
                       #if (id == "embcarbonro1"){browser()}
                       ## Update emissions in table here - this is in case we get updated EF library#
                       projectLifetime <- as.numeric(appR_returned$data$inputs_data_frame$Value[8])
                       tmpData_recalc <- left_join(tmpData,dropdown_options_temp, by = c("Category", "Sub Category", "Material", "Unit"))
                       # tmpData_recalc <- left_join(tmpData,efs_react$data$Material_Road, by = c("Category", "Sub Category", "Material", "Unit")) # need to add in a line before this to add manual EFs to dropdown options! Done see prev line
                       tmpData_recalc$`Embodied tCO2e` = tmpData_recalc$Quantity *  tmpData_recalc$`kgCO2e per unit` * kgConversion
                       tmpData_recalc$`Default Maintenance Percentage` = (projectLifetime / tmpData_recalc$`Regularity of maintenance cycle`) * tmpData_recalc$`% replaced in 1 maintenance cycle`
                       tmpData_recalc$`Default Maintenance Percentage`[is.nan(tmpData_recalc$`Default Maintenance Percentage`)] = 0 ## correct inf error from above
                       #tmpData_recalc$`Maintenance tCO2e` = tmpData_recalc$`Default Maintenance Percentage` * tmpData_recalc$`Embodied tCO2e`
                       tmpData_recalc[`Custom Maintenance`=="N", `Maintenance tCO2e` := `Default Maintenance Percentage` * `Embodied tCO2e`]
                       # tmpData_recalc <- tmpData_recalc[-c("kgCO2e per unit", "% replaced in 1 maintenance cycle", "Regularity of maintenance cycle")]
                       tmpData = tmpData_recalc[,1:ncol(tmpData)]
                       ### End
                       
                       rmecvalues$data = tmpData
                       embcarbon_returned$rmecTblResave = tmpData
                       
                       sum_emb_tCO2$data = sum(na.omit(tmpData$`Embodied tCO2e`)) # get emb carbon emissions
                       sum_maint_tCO2$data = sum(na.omit(tmpData$`Maintenance tCO2e`)) # get maint carbon emissions
                       
                     }
                     
                     
                     tmpData <- appR_returned$data[[paste0(id,"_transTbl")]]
                     colnames(tmpData) <- colnames(DF_trans)
                     tmpData$Comments <- as.character(tmpData$Comments)
                     tmpData$Unit <- as.character(tmpData$Unit)
                     #tmpData$`Distance Unit Mode 1` <- as.character(tmpData$`Distance Unit Mode 1`)
                     #tmpData$`Distance Unit Mode 2` <- as.character(tmpData$`Distance Unit Mode 2`)
                     transvalues$data <- tmpData
                     embcarbon_returned$transTblResave = tmpData
                     
                     sum_trans_tCO2$data = sum(na.omit(tmpData$`Transport tCO2e`)) # get transp carbon emissions
                     
                     
                     sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                     
                     embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                     
                     embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                     
                     
                     
                     tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                     colnames(tmpData) <- colnames(DF_csavoNoImpl)
                     tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                          `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                     colnames(tmpData) <- colnames(DF_csavoNoImpl)
                     embcarbon_returned$csavoNoImplTblResave <- tmpData
                     csavoNoImplvalues$data <- tmpData
                     
                     tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                          Stage = rep("Embodied Carbon", nrow(tmpData)))
                     tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                    Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                     embcarbon_returned$carbsavenotimp = tmpdat
                     
                     
                     tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                     colnames(tmpData) <- colnames(DF_csavoImpl)
                     tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                          `Rationale for implementation` = as.character(`Rationale for implementation`))
                     colnames(tmpData) <- colnames(DF_csavoImpl)
                     embcarbon_returned$csavoImplTblResave <- tmpData
                     csavoImplvalues$data <- tmpData
                     
                     tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                          Stage = rep("Embodied Carbon", nrow(tmpData)))
                     tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                    Rationale = tmpData$`Rationale for implementation`)]
                     embcarbon_returned$carbsaveimp = tmpdat
                     
                   }
                   
                 })
                 
                 
                 # Raw Materials - new bits ----------------------------------------------------------------
                 
                 output$rmecTbl <- DT::renderDT({
                   #browser()
                   DT = rmecvalues$data %>% dplyr::select(-`Custom Maintenance`)
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(6,7,8), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 
                 observeEvent(input$Add_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("rmec_add_col1"), label = "Category", 
                                    choices = dropdown_options_react$data %>% pull(Category) %>% unique %>% stringr::str_sort(numeric = TRUE)),
                     #selectizeInput(ns("rmec_add_col2"), label = "Sub Category", choices = rmec_subCat_choices()),
                     uiOutput(ns("rmec_add_col2_out")),
                     uiOutput(ns("rmec_add_col3_out")),
                     uiOutput(ns("material_flag_text")),
                     br(),
                     numericInput(ns("rmec_add_col4"), label = "Quantity", value = 0),
                     # selectizeInput(ns("rmec_add_col5"),
                     #                label = "Unit",
                     #                choices = c("ha", "m2", "km2", "mi2")),
                     uiOutput(ns("rmec_add_col5_out")),
                     br(),
                     #uiOutput(ns("rmec_add_flag_out")),
                     #textOutput(ns("material_flag_text")),
                     checkboxInput(ns("rmec_add_col_checkmaint"), label = "Use Custom Maintenance Value?", value = FALSE),
                     numericInput(ns("rmec_add_col_maint"), label = "Custom Maintenance tCO2e", value = 0),
                     br(),
                     textInput(ns("rmec_add_col9"), label = "Comments"),
                     actionButton(ns("go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 output$rmec_add_col2_out <- renderUI({
                   selectInput(ns("rmec_add_col2"), label = "Sub Category", choices = rmec_subCat_choices())
                 })
                 
                 rmec_subCat_choices <- reactive({
                   selected_row_category <- input$rmec_add_col1
                   subcat_options <- dropdown_options_react$data %>%
                     filter(Category == selected_row_category) %>%
                     select(`Sub Category`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$rmec_add_col3_out <- renderUI({
                   selectizeInput(ns("rmec_add_col3"), label = "Material", choices = rmec_mat_choices())
                 })
                 
                 rmec_mat_choices <- reactive({
                   
                   if (is.null(input$rmec_add_col2)){
                     selected_row_subcat <- dropdown_options_react$data %>% 
                       filter(Category == input$rmec_add_col1) %>% 
                       select(`Sub Category`) %>% distinct() %>% 
                       pull() %>% stringr::str_sort(numeric = TRUE) %>%
                       first()
                   } else {
                     selected_row_subcat <- input$rmec_add_col2
                   }
                   
                   selected_row_category <- input$rmec_add_col1
                   
                   material_options <- dropdown_options_react$data %>% 
                     filter(Category == selected_row_category & `Sub Category` == selected_row_subcat) %>%
                     select(Material) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 output$rmec_add_col5_out <- renderUI({
                   selectizeInput(ns("rmec_add_col5"), label = "Unit", choices = rmec_unit_choices()$Unit)
                 })
                 
                 # output$rmec_add_flag_out <- renderUI({
                 #   textInput(ns("rmec_add_flag"), label = as.character(embodied_carbon_materials_flag[Number == rmec_unit_choices()$Flag, `Flag Text`]))
                 # })
                 
                 output$material_flag_text <- renderUI({
                   HTML(paste0("<b>",as.character(embodied_carbon_materials_flag[Number == rmec_unit_choices()$Flag, `Flag Text`]),"</b>"))
                 })
                 
                 rmec_unit_choices <- reactive({
                   # if (is.null(input$rmec_add_col3)){
                   #   selected_row_subcat <- dropdown_options %>% 
                   #     filter(Category == input$rmec_add_col1) %>% 
                   #     select(`Sub Category`) %>% distinct() %>% 
                   #     pull() %>% stringr::str_sort(numeric = TRUE) %>%
                   #     first()
                   #   
                   # } else {
                   #   selected_row_subcat <- input$rmec_add_col2
                   # }
                   #browser()
                   selected_row_category <- input$rmec_add_col1
                   selected_row_subcat <- input$rmec_add_col2
                   selected_row_material <- input$rmec_add_col3
                   
                   if (is.null(input$rmec_add_col2)){
                     selected_row_subcat <- dropdown_options_react$data %>%
                       filter(Category == input$rmec_add_col1) %>%
                       select(`Sub Category`) %>% distinct() %>%
                       pull() %>% stringr::str_sort(numeric = TRUE) %>% first()
                     
                     selected_row_material <- dropdown_options_react$data %>%
                       filter(Category == input$rmec_add_col1 & `Sub Category` == selected_row_subcat) %>%
                       select(`Material`) %>% distinct() %>%
                       pull() %>% stringr::str_sort(numeric = TRUE) %>% first()
                   }
                   unit_options <- dropdown_options_react$data %>% 
                     filter(Category == selected_row_category & `Sub Category` == selected_row_subcat & Material == selected_row_material) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE) %>% first()
                   
                   flagtext_options <- dropdown_options_react$data %>% 
                     filter(Category == selected_row_category & `Sub Category` == selected_row_subcat & Material == selected_row_material) %>%
                     select(`Flag Text`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE) %>% first()
                   
                   returned <- list(Unit = unit_options,
                                    Flag = flagtext_options)
                 })
                 
                 
                 observeEvent(input$go, {
                   
                   new_row = data.frame(input$rmec_add_col1, 
                                        input$rmec_add_col2, 
                                        input$rmec_add_col3, 
                                        input$rmec_add_col4, 
                                        input$rmec_add_col5,
                                        "Default Maintenance Percentage" = 0,
                                        "Embodied tCO2e" = 0,
                                        "Maintenance tCO2e" = 0,
                                        input$rmec_add_col9,
                                        "Custom Maintenance" = "N")
                   
                   ## calculate maint
                   dropdown_subset = dropdown_options_react$data %>%
                     #browser()
                     filter(Category %in% input$rmec_add_col1) %>%
                     filter(`Sub Category` %in% input$rmec_add_col2) %>%
                     filter(Material %in% input$rmec_add_col3)
                   
                   perc_repl_1_maint_cycle <- dropdown_subset %>% select(`% replaced in 1 maintenance cycle`) %>% as.numeric()
                   regularity_maint_cycle <- dropdown_subset %>% select(`Regularity of maintenance cycle`) %>% as.numeric()
                   
                   if (regularity_maint_cycle <= 0.0 || is.na(regularity_maint_cycle)) { # catch for if dividing by zero also assume 0 for NA
                     default_maint_percent <- 0.0
                   } else {
                     default_maint_percent <- (projectdetails_values$lifeTime / regularity_maint_cycle) * perc_repl_1_maint_cycle # projectdetails_values$lifeTime
                   }
                   
                   new_row[6] = default_maint_percent
                   
                   # change this for calcs
                   ef_value <- dropdown_subset %>% select(`kgCO2e per unit`) %>% as.numeric()
                   
                   new_row[7] = new_row[4] * ef_value * kgConversion
                   new_row[8] = new_row[7] * new_row[6] 
                   
                   # Override default maintenance value if the following conditions are met
                   if (input$rmec_add_col_maint > 0 & input$rmec_add_col_checkmaint == TRUE){
                     new_row[8] = input$rmec_add_col_maint
                     new_row[10] = "Y"
                   }
                   
                   rmecvalues$data <- rbind(as.data.table(rmecvalues$data), as.data.table(new_row), use.names = F)
                   
                   sum_emb_tCO2$data <- sum(na.omit(rmecvalues$data$`Embodied tCO2e`))
                   sum_maint_tCO2$data <- sum(na.omit(rmecvalues$data$`Maintenance tCO2e`))
                   #sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                   
                   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                   
                   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   
                   embcarbon_returned$rmecTblResave = rmecvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(input$Del_row_head,{
                   showModal(
                     if(length(input$rmecTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete ",length(input$rmecTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$ok, {
                   
                   rmecvalues$data=rmecvalues$data[-input$rmecTbl_rows_selected,]
                   
                   sum_emb_tCO2$data <- sum(na.omit(rmecvalues$data$`Embodied tCO2e`))
                   sum_maint_tCO2$data <- sum(na.omit(rmecvalues$data$`Maintenance tCO2e`))
                   #sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                   
                   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   embcarbon_returned$rmecTblResave = rmecvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$mod_row_head,{
                   showModal(
                     if(length(input$rmecTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("rmec_mod_col1"), label = "Category", 
                                        choices = dropdown_options_react$data %>% pull(Category) %>% 
                                          unique %>% stringr::str_sort(numeric = TRUE),
                                        selected = rmecvalues$data[input$rmecTbl_rows_selected,1]),
                         uiOutput(ns("rmec_mod_col2_out")),
                         uiOutput(ns("rmec_mod_col3_out")),
                         uiOutput(ns("material_flag_text_mod")),
                         br(),
                         numericInput(ns("rmec_mod_col4"), label = "Quantity",
                                      value = rmecvalues$data[input$rmecTbl_rows_selected,4]),
                         uiOutput(ns("rmec_mod_col5_out")),
                         br(),
                         checkboxInput(ns("rmec_mod_col_checkmaint"), label = "Use Custom Maintenance Value?", 
                                       value = ifelse(!is.na(as.character(rmecvalues$data[input$rmecTbl_rows_selected, 10])) & 
                                                         as.character(rmecvalues$data[input$rmecTbl_rows_selected, 10])=="Y", TRUE, FALSE)),
                         numericInput(ns("rmec_mod_col_maint"), label = "Custom Maintenance tCO2e",
                                      value = ifelse(!is.na(as.character(rmecvalues$data[input$rmecTbl_rows_selected, 10])) & 
                                                       as.character(rmecvalues$data[input$rmecTbl_rows_selected, 10])=="Y", rmecvalues$data[input$rmecTbl_rows_selected, 8], 0)),
                         br(),
                         textInput(ns("rmec_mod_col9"), label = "Comments",
                                   placeholder = rmecvalues$data[input$rmecTbl_rows_selected,9]),
                         
                         hidden(numericInput(ns("rmec_mod_rown"), value = input$rmecTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$rmec_mod_col2_out <- renderUI({
                   selectInput(ns("rmec_mod_col2"), label = "Sub Category", choices = rmec_subCat_choices_mod(),
                               selected = rmecvalues$data[input$rmecTbl_rows_selected,2])
                 })
                 
                 rmec_subCat_choices_mod <- reactive({
                   selected_row_category <- input$rmec_mod_col1
                   subcat_options <- dropdown_options_react$data %>%
                     filter(Category == selected_row_category) %>%
                     select(`Sub Category`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$rmec_mod_col3_out <- renderUI({
                   selectizeInput(ns("rmec_mod_col3"), label = "Material", choices = rmec_mat_choices_mod(),
                                  selected = rmecvalues$data[input$rmecTbl_rows_selected,3])
                 })
                 
                 rmec_mat_choices_mod <- reactive({
                   if (is.null(input$rmec_mod_col2)){
                     selected_row_subcat <- dropdown_options_react$data %>%
                       filter(Category == input$rmec_mod_col1) %>%
                       select(`Sub Category`) %>% distinct() %>%
                       pull() %>% stringr::str_sort(numeric = TRUE) %>%
                       first()
                   } else {
                     selected_row_subcat <- input$rmec_mod_col2
                   }
                   selected_row_category <- input$rmec_mod_col1
                   material_options <- dropdown_options_react$data %>%
                     filter(Category == selected_row_category & `Sub Category` == selected_row_subcat) %>%
                     select(Material) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 output$rmec_mod_col5_out <- renderUI({
                   selectizeInput(ns("rmec_mod_col5"), label = "Unit", choices = rmec_unit_choices_mod()$Unit,
                                  selected = rmecvalues$data[input$rmecTbl_rows_selected,5])
                 })
                 
                 output$material_flag_text_mod <- renderUI({
                   HTML(paste0("<b>",as.character(embodied_carbon_materials_flag[Number == rmec_unit_choices_mod()$Flag, `Flag Text`]),"</b>"))
                 })
                 
                 rmec_unit_choices_mod <- reactive({
                   #browser()
                   selected_row_category <- input$rmec_mod_col1
                   selected_row_subcat <- input$rmec_mod_col2
                   selected_row_material <- input$rmec_mod_col3
                   
                   if (is.null(input$rmec_mod_col2)){
                     selected_row_subcat <- dropdown_options_react$data %>%
                       filter(Category == input$rmec_mod_col1) %>%
                       select(`Sub Category`) %>% distinct() %>%
                       pull() %>% stringr::str_sort(numeric = TRUE) %>% first()
                     
                     selected_row_material <- dropdown_options_react$data %>%
                       filter(Category == input$rmec_mod_col1 & `Sub Category` == selected_row_subcat) %>%
                       select(`Material`) %>% distinct() %>%
                       pull() %>% stringr::str_sort(numeric = TRUE) %>% first()
                   }
                   unit_options <- dropdown_options_react$data %>% 
                     filter(Category == selected_row_category & `Sub Category` == selected_row_subcat & Material == selected_row_material) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE) %>% first()
                   
                   flagtext_options <- dropdown_options_react$data %>% 
                     filter(Category == selected_row_category & `Sub Category` == selected_row_subcat & Material == selected_row_material) %>%
                     select(`Flag Text`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE) %>% first()
                   
                   returned <- list(Unit = unit_options,
                                    Flag = flagtext_options)
                   
                 })
                 
                 
                 observeEvent(input$confirm_mod, {
                   new_row = data.frame(input$rmec_mod_col1, 
                                        input$rmec_mod_col2, 
                                        input$rmec_mod_col3, 
                                        input$rmec_mod_col4, 
                                        input$rmec_mod_col5,
                                        "Default Maintenance Percentage" = 0,
                                        "Embodied tCO2e" = 0,
                                        "Maintenance tCO2e" = 0,
                                        input$rmec_mod_col9,
                                        "Custom Maintenance" = "N")
                   
                   ## calculate maint
                   dropdown_subset = dropdown_options_react$data %>%
                     filter(Category %in% input$rmec_mod_col1) %>%
                     filter(`Sub Category` %in% input$rmec_mod_col2) %>%
                     filter(Material %in% input$rmec_mod_col3)
                   
                   perc_repl_1_maint_cycle <- dropdown_subset %>% select(`% replaced in 1 maintenance cycle`) %>% as.numeric()
                   regularity_maint_cycle <- dropdown_subset %>% select(`Regularity of maintenance cycle`) %>% as.numeric()
                   
                   if (regularity_maint_cycle <= 0.0 || is.na(regularity_maint_cycle)) { # catch for if dividing by zero also assume 0 for NA
                     default_maint_percent <- 0.0
                   } else {
                     default_maint_percent <- (projectdetails_values$lifeTime / regularity_maint_cycle) * perc_repl_1_maint_cycle # projectdetails_values$lifeTime
                   }
                   
                   new_row[6] = default_maint_percent
                   
                   # CO2e calcs
                   ef_value <- dropdown_subset %>% select(`kgCO2e per unit`) %>% as.numeric()
                   
                   new_row[7] = new_row[4] * ef_value * kgConversion
                   new_row[8] = new_row[7] * new_row[6] 
                   
                   # Override default maintenance value if the following conditions are met
                   if (input$rmec_mod_col_maint > 0 & input$rmec_mod_col_checkmaint == TRUE){
                     new_row[8] = input$rmec_mod_col_maint
                     new_row[10] = "Y"
                   }
                   
                   #comments
                   if(input$rmec_mod_col9 == "") {
                     new_row[9] = rmecvalues$data[input$rmec_mod_rown, 9]
                   }
                   
                   rmecvalues$data[input$rmec_mod_rown,] <- new_row
                   
                   sum_emb_tCO2$data <- sum(na.omit(rmecvalues$data$`Embodied tCO2e`))
                   sum_maint_tCO2$data <- sum(na.omit(rmecvalues$data$`Maintenance tCO2e`))
                   #sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                   
                   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   embcarbon_returned$rmecTblResave = rmecvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$EmbCarb_Template_download <- downloadHandler(
                   filename = function(){template_filename},
                   content =function(file){file.copy(from = template_filepath,to = file)}
                 )
                 
                 
                 observeEvent(input$EmbCarb_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$EmbCarb_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(rmecvalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     # sift out any entries that do not have identical category/subcategory etc entries in the dropdown_options_react set
                     templateIn_sifted <- dplyr::inner_join(templateIn, dropdown_options_react$data,
                                                            by = c("Category", "Sub Category", "Material", "Unit"))[, 1:6]
                     
                     templateIn_unmatched <- dplyr::anti_join(templateIn, dropdown_options_react$data, # get the opposite - unmatched rows
                                                            by = c("Category", "Sub Category", "Material", "Unit"))[, 1:6]
                     
                     # display warning if any non-matching rows in the template have been sifted out due to not matching
                     if (nrow(templateIn_sifted) < nrow(templateIn)){
                       
                       if (nrow(templateIn_unmatched) <= 5){ # pick just the first 5 rows to present in modal popup
                         templateIn_unmatched_ui <- templateIn_unmatched
                       } else {
                         templateIn_unmatched_ui <- templateIn_unmatched[1:5,]
                       }
                       
                       showModal(
                         modalDialog(
                           
                           title = "Warning",
                           HTML(paste("Template upload - values in one or more rows could not be matched with those the emission factors library,
                                  and have therefore been omitted from the upload. <br><br>",
                                 "To use custom emission factors, these can be added to the emission factors library using the 'Add New Material' tab. <br><br>",
                                 "The first up to 5 rows omitted from the upload are shown in the table below: <br><br>")),
                           
                           reactable::reactable(templateIn_unmatched_ui),
                           easyClose = FALSE, size = "l",
                         )
                       )
                     }
                     
                     templateIn_sifted <- templateIn_sifted %>% filter(!is.na(`Quantity`))
                     
                     templateIn_data <- as.data.table(bind_rows(rmecvalues$data, templateIn_sifted))
                     templateIn_data[is.na(`Custom Maintenance`), `Custom Maintenance` := "N"] # convert any NAs to "N"
                     
                     for (i in 1:nrow(templateIn_data)){
                       ## calculate maint
                       # if dropdown_subset has 0 rows then no matches have been found - flag?
                       dropdown_subset = dropdown_options_react$data %>%
                         filter(Category %in% templateIn_data[i,1]) %>%
                         filter(`Sub Category` %in% templateIn_data[i,2]) %>%
                         filter(Material %in% templateIn_data[i,3])
                       
                       perc_repl_1_maint_cycle <- dropdown_subset %>% select(`% replaced in 1 maintenance cycle`) %>% as.numeric()
                       regularity_maint_cycle <- dropdown_subset %>% select(`Regularity of maintenance cycle`) %>% as.numeric()
                       
                       if (regularity_maint_cycle <= 0.0 || is.na(regularity_maint_cycle)) { # catch for if dividing by zero also assume 0 for NA
                         default_maint_percent <- 0.0
                       } else {
                         default_maint_percent <- (projectdetails_values$lifeTime / regularity_maint_cycle) * perc_repl_1_maint_cycle # projectdetails_values$lifeTime
                       }
                       
                       templateIn_data[i,6] = default_maint_percent
                       
                       # CO2e calcs
                       ef_value <- dropdown_subset %>% select(`kgCO2e per unit`) %>% as.numeric()
                       
                       templateIn_data[i,7] = templateIn_data[i,4] * ef_value * kgConversion
                       templateIn_data[i,8] = templateIn_data[i,7] * templateIn_data[i,6]
                     }
                     
                     rmecvalues$data = templateIn_data
                     
                     sum_emb_tCO2$data <- sum(na.omit(rmecvalues$data$`Embodied tCO2e`))
                     sum_maint_tCO2$data <- sum(na.omit(rmecvalues$data$`Maintenance tCO2e`))
                     #sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                     sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                     
                     embcarbon_returned$data$Value = c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                     embcarbon_returned$details = as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                     embcarbon_returned$rmecTblResave = rmecvalues$data
                     
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."), easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 # End of Raw Materials Embodied Carbon New Bits ---------------------------------------------------------
                 
                 # New Transport Tables -------------------------------------------------------------------------------------------
                 
                 #ns <- session$ns

                 output$transTbl <- DT::renderDT({
                   DT = transvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(4), currency = "", interval = 3, mark = ",", digits = 3)
                 })

                 observeEvent(input$trans_Add_row_head, {
                   ### This is the pop up board for input a new row
                  # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("trans_add_col1"), label = "Transport Type",
                                    choices = trans_mode_options$Vehicle %>% unique %>% stringr::str_sort(numeric = TRUE)),
                     numericInput(ns("trans_add_col2"), label = "Distance", value = 0),
                     selectizeInput(ns("trans_add_col3"), label = "Unit", choices = c("km")),
                     #uiOutput(ns("trans_add_col4_out")),
                     textInput(ns("trans_add_col5"), label = "Comments"),
                     actionButton(ns("trans_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })

                 observeEvent(input$trans_add_row_go, {
                   #browser()
                   new_row = data.frame(input$trans_add_col1,
                                        input$trans_add_col2,
                                        input$trans_add_col3,
                                        "Transport tCO2e" = 0, #output$trans_add_col4_out,
                                        input$trans_add_col5) %>%
                     dplyr::left_join(., trans_mode_options, by = c("input.trans_add_col1" = "Vehicle")) %>%
                     dplyr::mutate(Transport.tCO2e = input.trans_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -c(Category:Reference))
                   
                   transvalues$data <- data.table(rbind(transvalues$data, new_row, use.names = F))
                   sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                   
                   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   embcarbon_returned$transTblResave = transvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$trans_Del_row_head,{
                   showModal(
                     if(length(input$transTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$transTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("trans_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })

                 observeEvent(input$trans_del_row_ok, {
                   
                   transvalues$data=transvalues$data[-input$transTbl_rows_selected,]
                   sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                   
                   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   embcarbon_returned$transTblResave = transvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$trans_mod_row_head,{
                   showModal(
                     if(length(input$transTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("trans_add_col1"), label = "Transport Type", 
                                        choices = trans_mode_options$Vehicle %>% 
                                          unique %>% stringr::str_sort(numeric = TRUE),
                                        selected = transvalues$data[input$transTbl_rows_selected,1]),
                         numericInput(ns("trans_add_col2"), label = "Distance", value = transvalues$data[input$transTbl_rows_selected,2]),
                         selectizeInput(ns("trans_add_col3"), label = "Unit", choices = c("km")),
                         uiOutput(ns("trans_add_col4_out"), placeholder = transvalues$data[input$transTbl_rows_selected,4]),
                         textInput(ns("trans_add_col5"), label = "Comments", placeholder = transvalues$data[input$transTbl_rows_selected,5]),
                         
                         hidden(numericInput(ns("trans_mod_rown"), value = input$transTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("trans_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$trans_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$trans_add_col1,
                                        input$trans_add_col2,
                                        input$trans_add_col3,
                                        "Transport tCO2e" = 0, #output$trans_add_col4_out,
                                        input$trans_add_col5) %>%
                     dplyr::left_join(., trans_mode_options, by = c("input.trans_add_col1" = "Vehicle")) %>%
                     dplyr::mutate(Transport.tCO2e = input.trans_add_col2 * `kgCO2e per unit`* kgConversion) %>%
                     dplyr::select(., -c(Category:Reference))
                   
                   transvalues$data[input$trans_mod_rown,] <- new_row
                   
                   sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                   
                   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   embcarbon_returned$transTblResave = transvalues$data
                   
                   removeModal()
                 })
                 
                 output$EmbCarb_Trans_Template_download <- downloadHandler(
                   filename = function(){"Road_Embodied_Carbon_Transport.xlsx"},
                   content =function(file){file.copy(from = "Templates/Road_Embodied_Carbon_Transport.xlsx",to = file)}
                 )

                 observeEvent(input$EmbCarb_Trans_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$EmbCarb_Trans_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(transvalues$data)[1:3])){
                     
                     if (typeof(templateIn$Distance) == "character"){templateIn$Distance <- as.numeric(templateIn$Distance)}
                     
                     templateIn <- templateIn %>% filter(!is.na(`Distance`))
                     
                     templateIn_data <- bind_rows(transvalues$data, templateIn) %>%
                       dplyr::left_join(., trans_mode_options[, c("Vehicle","kgCO2e per unit")], by = c("Transport Type" = "Vehicle")) %>%
                       dplyr::mutate(`Transport tCO2e` = Distance * `kgCO2e per unit`* kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Distance > 0)
                     
                     transvalues$data <- templateIn_data
                     
                     sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                     sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                     
                     embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                     embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                     embcarbon_returned$transTblResave = transvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 #     
                 #     
                 #     ## calculate maint
                 #     dropdown_subset = dropdown_options %>%
                 #       filter(Category %in% templateIn_data[i,1]) %>%
                 #       filter(`Sub Category` %in% templateIn_data[i,2]) %>%
                 #       filter(Material %in% templateIn_data[i,3])
                 #     
                 #     dropdown_subset = dropdown_options %>%
                 #       filter(Category %in% templateIn_data[i,1]) %>%
                 #       filter(`Sub Category` %in% templateIn_data[i,2]) %>%
                 #       filter(Material %in% templateIn_data[i,3])
                 #     
                 #     perc_repl_1_maint_cycle <- dropdown_subset %>% select(`% replaced in 1 maintenance cycle`) %>% as.numeric()
                 #     regularity_maint_cycle <- dropdown_subset %>% select(`Regularity of maintenance cycle`) %>% as.numeric()
                 #     
                 #     if (regularity_maint_cycle <= 0.0 || is.na(regularity_maint_cycle)) { # catch for if dividing by zero also assume 0 for NA
                 #       default_maint_percent <- 0.0
                 #     } else {
                 #       default_maint_percent <- (projectdetails_values$lifeTime / regularity_maint_cycle) * perc_repl_1_maint_cycle # projectdetails_values$lifeTime
                 #     }
                 #     
                 #     templateIn_data[i,6] = default_maint_percent
                 #     
                 #     # CO2e calcs
                 #     ef_value <- dropdown_subset %>% select(`kgCO2e per unit`) %>% as.numeric()
                 #     
                 #     templateIn_data[i,7] = templateIn_data[i,4] * ef_value * kgConversion
                 #     templateIn_data[i,8] = templateIn_data[i,7] * templateIn_data[i,6]
                 #   }
                 #   
                 #   rmecvalues$data <- templateIn_data
                 #   
                 #   sum_emb_tCO2$data <- sum(na.omit(rmecvalues$data$`Embodied tCO2e`))
                 #   sum_maint_tCO2$data <- sum(na.omit(rmecvalues$data$`Maintenance tCO2e`))
                 #   #sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                 #   sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                 #   
                 #   embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                 #   
                 #   embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                 #   
                 #   
                 
                 
                 # End of New Transport Tables -------------------------------------------------------------------------------
                 
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
                                       Stage = rep("Embodied Carbon", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   embcarbon_returned$carbsavenotimp <- tmpdf
                   embcarbon_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("Embodied Carbon", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   embcarbon_returned$carbsavenotimp <- tmpdf
                   embcarbon_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("Embodied Carbon", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   embcarbon_returned$carbsavenotimp <- tmpdf
                   embcarbon_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 
                 # Carbon saving options (Implementation) ----
                 # output$csavoImplTbl <- renderRHandsontable({
                 #   rhandsontable(csavoImplvalues$data, rowHeaders = NULL, height = rhandsontable_defaultheight, stretchH = "all")
                 # })
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
                                       Stage = rep("Embodied Carbon", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   embcarbon_returned$carbsaveimp <- tmpdf
                   embcarbon_returned$csavoImplTblResave = csavoImplvalues$data
                   
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
                                       Stage = rep("Embodied Carbon", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   embcarbon_returned$carbsaveimp <- tmpdf
                   embcarbon_returned$csavoImplTblResave = csavoImplvalues$data
                   
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
                                       Stage = rep("Embodied Carbon", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   embcarbon_returned$carbsaveimp <- tmpdf
                   embcarbon_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 ##  Observe changes to the project lifetime and update the rhandsontable maintenance percentage based on this
                 observeEvent(projectdetails_values$lifeTime, {  #  req(input$rmecTbl, projectdetails_values$lifeTime)
                   #if (id == "embcarbonro1"){browser()}
                   #observer for lifetime change
                   if (length(which(rmecvalues$data$Quantity > 0)) > 0){ # prevents code block running when app (and 'projectdetails_values' reactive) initialise
                     #
                     #rmecvalues$data <- hot_to_r(input$rmecTbl) # convert the rhandsontable to R data frame object so manipulation / calculations could be done
                     
                     #browser()
                     for (i in 1:length(which(rmecvalues$data$Quantity > 0))){  # (i in 1:length(which(rmecvalues$data$Quantity > 0)))    (i in 1:nrow(rmecvalues$data))
                       
                       dropdown_subset = dropdown_options_react$data %>%
                         filter(Category %in% rmecvalues$data$Category[i]) %>%
                         filter(`Sub Category` %in% rmecvalues$data$`Sub Category`[i]) %>%
                         filter(Material %in% rmecvalues$data$Material[i])
                       
                       perc_repl_1_maint_cycle <- dropdown_subset %>% select(`% replaced in 1 maintenance cycle`) %>% as.numeric()
                       regularity_maint_cycle <- dropdown_subset %>% select(`Regularity of maintenance cycle`) %>% as.numeric()
                       
                       if (regularity_maint_cycle <= 0.0 || is.na(regularity_maint_cycle)) { # catch for if dividing by zero also assume 0 for NA
                         default_maint_percent <- 0.0
                       } else {
                         default_maint_percent <- (projectdetails_values$lifeTime / regularity_maint_cycle) * perc_repl_1_maint_cycle
                       }
                       
                       rmecvalues$data[i, 6] <- default_maint_percent
                       
                       # CO2e calcs
                       ef_value <- dropdown_subset %>% select(`kgCO2e per unit`) %>% as.numeric()
                       
                       rmecvalues$data[i, 7] = rmecvalues$data[i, 4] * ef_value * kgConversion
                       
                       # Recalculate default maintenance value if custom maintenance is set to "N", or NA (NA error catch)
                       if (is.na(rmecvalues$data[i, 10]) | is.null(rmecvalues$data[i, 10]) | rmecvalues$data[i, 10] == "N"){
                         rmecvalues$data[i, 8] = rmecvalues$data[i, 7] * rmecvalues$data[i, 6]
                       }
                     }
                     
                     sum_emb_tCO2$data <- sum(na.omit(rmecvalues$data$`Embodied tCO2e`))
                     sum_maint_tCO2$data <- sum(na.omit(rmecvalues$data$`Maintenance tCO2e`))
                     sum_trans_tCO2$data <- sum(na.omit(transvalues$data$`Transport tCO2e`))
                     sum_embcarbon_tCO2$data <- sum(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data)
                     
                     embcarbon_returned$data$Value <- c(sum_emb_tCO2$data, sum_maint_tCO2$data, sum_trans_tCO2$data, sum_embcarbon_tCO2$data)
                     embcarbon_returned$details <- as.data.table(rmecvalues$data)[, c("Category","Embodied tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                     embcarbon_returned$rmecTblResave = rmecvalues$data
                   }
                 })
                 
                 
                 # For adding NEW materials, filter Material Subcategory based on user's choice of Category
                 observeEvent(input$new_material_category, {
                   
                   #print("observing change in material_category")
                   
                   # Switch selection depending on Road or Rail Option
                   if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
                     x <- data.table(efs_react$data$Material_Road)
                   } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
                     x <- data.table(efs_react$data$Material_Rail)
                   } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
                     x <- data.table(efs_react$data$Material_Road)
                   }
                   
                   x <- x %>%
                     filter(Category == input$new_material_category) %>% #material_category
                     select(`Sub Category`) %>%
                     unique(.)
                   
                   #
                   
                   updateSelectInput(session = session, inputId = "new_material_subcategory", label = "Enter Material Sub-Category",
                                     choices = as.character(x$`Sub Category`))
                   
                 })
                 
                 
                 
                 # Create modal popup boxes
                 popupModalSuccess <- function(){
                   modalDialog(title = h3("New Material Successfully Added!"),
                               footer = tagList(
                                 modalButton(label = "OK"),
                               )
                   )
                 }
                 
                 popupModalFail <- function(){
                   modalDialog(title = h3("Material NOT Added. Please Fill Out All Fields!"),
                               footer = tagList(
                                 modalButton(label = "Back"),
                               )
                   )
                 }
                 
                 # popupModalDup <- function(){
                 #   modalDialog(title = h3("Material NOT Added."), 
                 #               span(HTML("Please ensure material name is unique.<br>")),
                 #               span(" The material name entered already exists in the tool's materials library."),
                 #               footer = tagList(
                 #                 modalButton(label = "Back"),
                 #               )
                 #   )
                 # }
                 
                 
                 # Add new material into Emission Factors database on button press
                 observeEvent(input$addnewbutton, {
                   
                   # Switch selection depending on Road or Rail Option
                   if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
                     tmpdf <- data.table(efs_react$data$Material_Road)
                   } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
                     tmpdf <- data.table(efs_react$data$Material_Rail)
                   } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
                     tmpdf <- data.table(efs_react$data$Material_Road)
                   }
                   
                   if (input$new_material_name == "" |
                       input$new_material_category == "" |
                       is.null(input$new_material_unit) | 
                       is.null(input$new_material_kgCO2e) | 
                       input$new_material_reference == ""
                   ){
                     
                     # Open modal popup box
                     showModal(popupModalFail())
                     
                   } else {
                     
                     # Create data.table row for new material to append to main EFs table
                     x <- data.table(Material = input$new_material_name,
                                     Category = input$new_material_category,
                                     `Sub Category` = input$new_material_subcategory,
                                     Unit = input$new_material_unit,
                                     `kgCO2e per unit` = input$new_material_kgCO2e,
                                     Reference = input$new_material_reference,
                                     Manual = "MANUAL", # always set user defined as MANUAL
                                     `% replaced in 1 maintenance cycle` = 0.0,
                                     `Regularity of maintenance cycle` = 0.0
                     )
                     
                     # if (any(x$Material == tmpdf$Material)){ # check for dupl;icated material name
                     #   showModal(popupModalDup())
                     # } else {
                     
                     tmpdf <- rbindlist(list(tmpdf, x), fill = T, use.names = T)
                     
                     # Reset all input fields
                     
                     updateTextInput(inputId = "new_material_name", value = "")
                     
                     updateNumericInput(inputId = "new_material_kgCO2e", value = 0)
                     
                     updateSelectInput(inputId = "new_material_unit", choices = unique(tmpdf$Unit), selected = unique(tmpdf$Unit)[1])
                     
                     updateTextInput(inputId = "new_material_reference", value = "")
                     
                     updateSelectInput(inputId = "new_material_category", choices = unique(tmpdf$Category), selected = unique(tmpdf$Category)[1])
                     
                     updateSelectInput(inputId = "new_material_subcategory", choices = unique(tmpdf$`Sub Category`), selected = unique(tmpdf$`Sub Category`)[1])
                     
                     # Update 'efs_react' and 'efs_materialroad_userinput'
                     if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
                       
                       efs_react$data$Material_Road <- tmpdf
                       # efs$Material_Road <- tmpdf # removed AB, we don't want to write to efs which is a global var, I don't think thsi does anything anyway because not returned by function
                       efs_materialroad_userinput$data <- rbind(efs_materialroad_userinput$data, x, use.names = T, fill = T)
                       
                     } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
                       
                       efs_react$data$Material_Rail <- tmpdf
                       # efs$Material_Rail <- tmpdf # removed AB, we don't want to write to efs which is a global var, I don't think thsi does anything anyway because not returned by function
                       efs_materialrail_userinput$data <- rbind(efs_materialrail_userinput$data, x, use.names = T, fill = T)
                       
                     } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
                       
                       efs_react$data$Material_Road <- tmpdf
                       # efs$Material_Road <- tmpdf # removed AB, we don't want to write to efs which is a global var, I don't think thsi does anything anyway because not returned by function
                       efs_materialroad_userinput$data <- rbind(efs_materialroad_userinput$data, x, use.names = T, fill = T)
                       
                     }
                     
                     # Export back to Excel with new added material
                     #rio::export(efs_react$data, "emission_factors/Emission_Factors.xlsx", overwrite = T)  #  DO NOT CURRENTLY WANT TO WRITE NEW EFS BACK TO SPREADSHEET
                     
                     # Open modal popup box
                     showModal(popupModalSuccess())
                   }
                 })
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
                 
               }, session = getDefaultReactiveDomain()
  )
  
  return(embcarbon_returned)
  
}

ToolVersion1 <- "Version 0.5.0"
ReleaseDate1 <- "December 2022"
Issue1 <- "Beta version"
Change1 <- ""


ToolVersion2 <- "Version 0.6.0"
ReleaseDate2 <- "25th May 2023"
Issue2 <- "Tool user guide PDF and race case issue in editable tables."
Change2 <- "Addition of tool PDF and change to table data cycle method."


ToolVersion3 <- "Version 0.6.19"
ReleaseDate3 <- "15th September 2023"
Issue3 <- "Load file data shedding."
Change3 <- "Updated file load/save protocol, no change to file format from user perspective."


ToolVersion4 <- "Version 0.7.0"
ReleaseDate4 <- "6th October 2023"
Issue4 <- "Additional construction activity table required for total fuel use. Additional EFs required, fix to waste emissions for 'Reuse Off-Site' materials."
Change4 <- "Table added to construction activities section of the tool. Update to EF library."

ToolVersion5 <- "Version 0.7.4"
ReleaseDate5 <- "15th March 2024"
Issue5 <- "Updates required to the emissions factor library."
Change5 <- paste0("Updates to the emissions library have been made. When loading a project, tables will be automatically updated with these emissions factors. For additional detail please contact tool support ", mailto,".")

ToolVersion6 <- "Version 0.7.5"
ReleaseDate6 <- "30th April 2024"
Issue6 <- "Updates required to prevent duplicate materials in emissions factor library."
Change6 <- "Error catch added to Add New Material function."

ToolVersion7 <- "Version 0.7.8"
ReleaseDate7 <- "August 2024"
Issue7 <- "Updates required to prevent duplicate materials in emissions factor library. v2"
Change7 <- "Protocol to clean duplicated materials embeded in .sav files"

ToolVersion8 <- "Version 0.7.9"
ReleaseDate8 <- "November 2024"
Issue8 <- "Updates to emissions factor library."
Change8 <- "Updates include embodied carbon materials added for kerbs and precast retaining walls and separation of transport from waste emissions"

ToolVersion9 <- "Version 0.7.10"
ReleaseDate9 <- "January 2025"
Issue9 <- "User Guide URL has changed"
Change9 <- "Update to URL"

ToolVersion10 <- "Version 0.8.0"
ReleaseDate10 <- "May 2025"
Issue10 <- "Comprehensive update of emissions factor library."
Change10 <- "Comprehensive update of road and rail material embodied carbon emission factors to ICE database version 4.0 (released Dec 2024)"

ToolVersion11 <- "Version 0.9.0"
ReleaseDate11 <- "September 2025"
Issue11 <- "Major updates to tool data entry functionality."
Change11 <- "Major updates to tool data entry functionality, and stability fixes. Includes table template download/upload functionality, table row data entry via popup boxes, ability to add custom maintenance emissions to embodied carbon section."


changes <- tibble("Tool Version" = c(ToolVersion11, ToolVersion10, ToolVersion9, ToolVersion8, ToolVersion7, ToolVersion6, ToolVersion5, ToolVersion4, ToolVersion3, ToolVersion2, ToolVersion1),
                  "Release Date" = c(ReleaseDate11, ReleaseDate10, ReleaseDate9, ReleaseDate8, ReleaseDate7, ReleaseDate6, ReleaseDate5, ReleaseDate4, ReleaseDate3, ReleaseDate2, ReleaseDate1),
                  Issue = c(Issue11, Issue10, Issue9, Issue8, Issue7, Issue6, Issue5, Issue4, Issue3, Issue2, Issue1),
                  `Description of changes` = c(Change11, Change10, Change9, Change8, Change7, Change6, Change5, Change4, Change3, Change2, Change1))


ccontrol_ui <- function(id,tabName){
  ns <- NS(id)
  tabItem(tabName = tabName,
          box(
            width = 12,
            fluidRow(
              column(
                width = 8,
                h6(HTML("<br>")),
                h3(
                  tagList(
                    HTML("&nbsp;"),
                    ccontrol_icon,
                    HTML("&nbsp;"),
                    textOutput(ns("some_title"), inline = T)
                    )
                  )),
                column(
                  width = 4,
                  align = "right",
                  h3(tagList(
                    HTML("&nbsp;"), span(img(src = "TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;")
                    ))
                  )
            )
                ),
                box(
                  width = 12,
                  tableHTML(
                    changes,
                    rownames = F,
                    widths = c(200, 200, 500, 500),
                    escape = F
                  ) %>%
                    add_css_thead(css = list('background-color', '#008768')) %>%
                    add_css_thead(css = list('color', 'white'))
                )
          )
          
}

ccontrol_server <- function(id,thetitle, thoutput){
  
  moduleServer(id,
               function(input, output, session){
                 output$some_title <- renderText({thetitle})
               }, session = getDefaultReactiveDomain()
  )
}

# Function to save rHandsontables to csv file

save_rhandsontable <- function(tbl_id, tbl_inputs){
  wd <- choose.dir()
  inputs <- cbind(tbl_id, tbl_inputs) %>%
    write.csv(inputs, file = paste0(wd,"/",tbl_id,"_Save.sav"), row.names = FALSE)
}

# Function to load rHandsontables from csv file
load_rhandsontable <- function(tbl_id, tbl_inputs){
  mytable <- read.csv(file.choose(), header = T) %>%
    dplyr::filter(mytable, mytable[,1] == tbl_id) %>% 
    mytable[,c(-1, -6)] %>%
    mytable$Embeded_Carbon <- mytable$Category * mytable$Subcategory * mytable$Quantity
  tbl_values <- mytable
}

inputs <- datavalues$data
inputs <- cbind("hotable1", inputs)
write.csv(inputs, file = paste0(wd,"/TestSave.sav"), row.names = FALSE)

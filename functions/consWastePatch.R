

wastePatch <- function(wasteTable, dropdown_options) {
  
  rowstoCalc <- which(wasteTable$`Waste Route` == "Reuse Off-Site")
  
  if (length(rowstoCalc) >= 1) {
        
        for (i in 1:length(rowstoCalc)){
          
          ef_value = dropdown_options %>%
            filter(`Waste Type` %in% wasteTable[rowstoCalc[i],1]) %>%
            filter(`Waste Route` %in% wasteTable[rowstoCalc[i],2]) %>%
            select(`kgCO2e per unit`)
          
          wasteTable[rowstoCalc[i], 8] = wasteTable[rowstoCalc[i],3] * ef_value * kgConversion
        }
    }
  return(wasteTable)
}
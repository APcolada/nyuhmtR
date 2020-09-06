#' A uHMT Data Exporting Function
#'
#' This function writes out uHMT data files as multiple csv's, depending on the number of objects in the provided list. It is usually used to write out csv files indvidually for each station.
#' @param lsofuhmt a list containing one data frame per station.
#' @param filename a string to assign to the beginning of the csv filename. This arguement is optional, where the default is "uhmt_csv_stationname.csv".
#'


## Write csv files from a list of uhmt stations data
uHMT_write_csv <- function(lsofuhmt, filename = NULL){
  for (n in 1:length(lsofuhmt)){
    temp.stname <- names(lsofuhmt)[n]
    if(!is.null(filename)){
      write.csv(lsofuhmt[[n]], file= paste(filename,temp.stname,".csv",sep=""),
                quote= FALSE, dec= ".", row.names = FALSE)
    }
    else {
      write.csv(lsofuhmt[[n]], file= paste("uhmt_",temp.stname,".csv",sep=""),
                quote= FALSE, dec= ".", row.names = FALSE)
    }
  }
  print(paste0(as.character(length(lsofuhmt)," files written to: ",getwd())))
}

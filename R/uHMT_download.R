#' A uHMT Get Data Function
#' 
#' This function downloads uHMT data files from the NOAA CESSRST online database.
#' @param omit.siten Which stations (identified by station number) would you like to not download. Defaults to all sites except the first one. Thus only site 1 data will download.
#' 
#' @export
#' @examples
#' ## The below expression will download all uHMT station's
#' ##  data except station numbers 4, 17, and 19
#' uhmt_ls <- uHMT_download(omit.siten = c(4,17,19))


uHMT_download <- function(omit.siten = c(2:19)){
  # Setup dataframe to scrape uHMT data from desired stations
  url.df <- data.frame(NYuHMTdb = rep("https://datadb.noaacrest.org/public/uhmt/Data/",19),
                       listofsites = c("1_QBG","2_QCC","3_REM","4_BPL","5_MTP","6_DKN","7_WBG","8_PGD",
                                       "9_FRW","10_BAY","11_BPK","12_ERV","13_AST","14_HBR","15_WWM","16_JHS",
                                       "17_BHS","18_MDC","19_MKI"),
                       lognet = rep("_Loggernet_Data/",19),
                       sitesdatanm = c("Site1_Queens_Botanical_Garden",
                                       "Site2_Queensborough_Community_College",
                                       "Site3_Ronald_Edmonds_Learning_Center",
                                       "Site4_Brownsville_Library",
                                       "Site5_Middletown_Houses",
                                       "Site6_Dyckman_Houses",
                                       "Site7_Williamsburg_Houses",
                                       "Site8_Polo_Ground",
                                       "Site9_Far_Rockaway",
                                       "Site10_BayView",
                                       "Site11_Baisley_Park",
                                       "Site12_East_River",
                                       "Site13_Astoria",
                                       "Site14_Haber_Coney_Island",
                                       "Site15_Walt_Whitman_MS",
                                       "Site16_JHS_High_School",
                                       "Site17_BHS_High_School",
                                       "Site18_MDC_School",
                                       "Site19_MKI_School"),
                       sitesdata15 = rep("_Fifteen.dat",19))

  url.df_new <- url.df[-omit.siten,]
  uHMT_files <- list()
  url.4readingdata <- array(NA,dim= nrow(url.df_new))

  # Scrape data from online CESSRST database
  for (i in 1:nrow(url.df_new)){
    url.4readingdata[i] <- paste(url.df_new[i,1], url.df_new[i,2], url.df_new[i,3],
                                 url.df_new[i,4], url.df_new[i,5], sep = "")
    uHMT_files[[i]] <- read.delim(url.4readingdata[i], header=FALSE, skip= 4, sep=",", as.is= TRUE)
  }

  # Column labels for each dataframe
  collabels = c("Timestamp","Record","VWC","T","P","VWC_2","T_2","P_2","VWC_3","T_3","P_3","VWC_4","T_4","P_4","AirTF","RH","Rainfall_Tot","Snowfall_Tot")

  # Apply column labels to each dataframe
  uHMT_files <- lapply(seq(uHMT_files), function(i){
    y <- data.frame(uHMT_files[[i]])
    colnames(y) <- collabels
    return(y)
  })
  # Give names of dataframes in the list
  names(uHMT_files) <- url.df_new$listofsites

  return(invisible(uHMT_files))
}

library(httr)
library(jsonlite)

# Base URL for the API
url <- "https://dashboard.e-stat.go.jp/api/1.0/Json/getData?Lang=EN&IndicatorCode="

# Function to fetch data using a single indicator code
get_japanstats <- function(indicator_code, time = "2017CY00", regionalRank = "3", cycle = "3", seasonalAdjustment = "1") {
  # Construct the API URL with the specified parameters
  full_url <- paste0(url, indicator_code,
                     "&Time=", time,
                     "&RegionalRank=", regionalRank,
                     "&Cycle=", cycle,
                     "&IsSeasonalAdjustment=", seasonalAdjustment)

  api_call <- GET(full_url)

  # Check the response and process accordingly
  if (status_code(api_call) == 200) {
    content <- content(api_call, "text", encoding = "UTF-8")
    parsed_content <- jsonlite::fromJSON(content)

    # Assuming you're interested in the 'RESULT' part of the response
    data <- parsed_content$GET_STATS$STATISTICAL_DATA$DATA_INF$DATA_OBJ

    return(data)

  } else {
    stop("API request failed with status: ", status_code(api_call))
  }
}

# Using example indicator codes from your JavaScript example
test_indicator_code <- "0201010010000020010" # You can replace this with the actual indicator code you want to use
result <- get_japanstats(test_indicator_code)
print(result)

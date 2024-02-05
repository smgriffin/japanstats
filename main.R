library(httr)

url <- "https://dashboard.e-stat.go.jp/api/1.0/Json/getData?Lang=JP&IndicatorCode="

get_japanstats <- function(indicator, interval, region, seasonal_adj)
{
  full_url <- paste0(url,
                    indicator,
                    interval,
                    region,
                    seasonal_adj)

  api_call <- GET(full_url)

  if (status_code(api_call) == 200)
  {
    content <- content(api_call, "text")
    parse_content <- jsonlite::fromJSON(content)

    data <- parse_content$GET_STATS$RESULT

    return(data)
  }
  else
  {
    stop("API request failed with status: ", status_code(api_call))
  }
}




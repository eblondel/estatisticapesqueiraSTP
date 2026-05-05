
#' Add leading zero to single-character values
#'
#' This function standardises character values by adding a leading zero
#' to any element whose string length is equal to one. Values with more
#' than one character are returned unchanged.
#'
#' @param data A vector (typically character or numeric) to be processed.
#'
#' @return A vector of the same length as `data`, where single-character
#'   elements are prefixed with `"0"`.
#'
#' @details
#' The function converts all elements to character internally and checks
#' their string length using `nchar()`. If an element has length 1, it is
#' transformed using `paste0("0", x)`.
#'
#' @examples
#' \dontrun{
#' add0(c("1", "2", "10"))
#' # returns: "01" "02" "10"
#' }
#'
#' @export
add0 <- function(data) unlist(lapply(data,
                                       function(x)
                                         if(nchar(x) == 1)
                                           paste0("0", x) else x
))




#' @export
coalesce_to <- function(x, coalesce_null = TRUE, coalesce_na = FALSE, replacement = NA){
  if(coalesce_null) if(is.null(x)) x = replacement
  if(coalesce_na) if(is.na(x)) x = replacement
  return(x)
}

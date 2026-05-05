
#' @export
get_config_from_local = function(config      = file.path("inst", "config"),
                                 cache       = file.path("inst", "cache"),
                                 others = list()) {

  variables = readxl::read_excel(file.path(config, "forms.xlsx"), sheet = "vars")
  nams      = levels(as.factor(variables$dat))
  variables = lapply(levels(as.factor(variables$dat)), function(datname)
    table_to_list(variables[which(variables$dat == datname),],
                  label = "variablename"))
  names(variables) = nams

  files = readxl::read_excel(file.path(config, "files.xlsx"), sheet = "conf")
  repo = readxl::read_excel(file.path(config, "repo.xlsx"), sheet = "repo")


  c(list(
    cleaning_function =
      local({
        filepath = file.path(config, "clean_new_data.R")
        if(file.exists(filepath)){
          source(filepath, local = TRUE)
          if(exists("cleaning_function")) get("cleaning_function") else NULL
        } else NULL
      }),

    repository_name  =
      repo$repository_title,


    repository_location =
      repo$repository_location,


    zenodo = list(instance     = repo$zenodo_instance,
                  description  = repo$zenodo_description,
                  creators     = table_to_list(readxl::read_excel(file.path(config, "repo.xlsx"), sheet = "zenodo_creators"))
                  ),




    forms =
      table_to_list(readxl::read_excel(file.path(config, "forms.xlsx"), sheet = "forms"),
                    label = "parent"),


    databases =
      table_to_list(readxl::read_excel(file.path(config, "forms.xlsx"), sheet = "dat"),
                    label = "dat"),

    variables = variables,


    cache  = cache,


    last_session = if(file.exists(file.path(cache, "settings.rds")))
      readRDS(file.path(cache, "settings.rds")) else NULL,


    config = list(
      local_data_directory = files$local_data_directory,
      method               = files$method,
      fileformat           = files$fileformat,
      grouping_variable    = files$group,
      csv_separator        = files$csv_separator
    )

  ),
  others)

}

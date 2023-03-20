# Aggregate NTL by Time

# Load data --------------------------------------------------------------------
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", paste0("adm2", "_", "VNP46A2", ".Rds")))
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

eq_df <- eq_df %>%
  dplyr::select(pcode, adm2_en)

# Aggregate --------------------------------------------------------------------
agg_ntl <- function(ntl_df, start, end){
  df_out <- ntl_df %>%
    dplyr::filter(date %in% ymd(start):ymd(end)) %>%
    group_by(pcode) %>%
    dplyr::summarise(ntl_bm_mean = mean(ntl_bm_mean)) %>%
    ungroup()
  
  names(df_out)[2] <- paste0("ntl_",
                             start %>% str_replace_all("-", ""), "_",
                             end %>% str_replace_all("-", ""))
  
  return(df_out)
}

ntl_sum_df <- list(agg_ntl(ntl_df, "2023-02-06", "2023-02-06"),
                   agg_ntl(ntl_df, "2023-02-06", "2023-02-07"),
                   agg_ntl(ntl_df, "2023-02-06", "2023-02-08"),
                   
                   agg_ntl(ntl_df, "2023-02-05", "2023-02-05"),
                   agg_ntl(ntl_df, "2023-02-04", "2023-02-05"),
                   
                   agg_ntl(ntl_df, "2023-01-01", "2023-02-05"),
                   
                   agg_ntl(ntl_df, "2023-02-06", "2023-02-06"),
                   agg_ntl(ntl_df, "2023-02-06", "2023-02-07"),
                   
                   agg_ntl(ntl_df, "2023-01-23", "2023-02-05"),
                   
                   agg_ntl(ntl_df, "2023-01-26", "2023-01-22"),
                   agg_ntl(ntl_df, "2023-01-23", "2023-01-29"),
                   agg_ntl(ntl_df, "2023-01-30", "2023-02-05"),
                   
                   agg_ntl(ntl_df, "2023-02-06", "2023-02-12"),
                   agg_ntl(ntl_df, "2023-02-13", "2023-02-19"),
                   agg_ntl(ntl_df, "2023-02-20", "2023-02-26")) %>% 
  reduce(left_join, by = "pcode") %>%
  left_join(eq_df, by = "pcode") %>%
  dplyr::select(pcode, adm2_en, everything()) %>%
  arrange(adm2_en)

write_csv(ntl_sum_df, file.path(ntl_bm_dir, "FinalData", "aggregated", 
                                "ntl_aggregated_by_time_period.csv"))

saveRDS(ntl_sum_df, file.path(ntl_bm_dir, "FinalData", "aggregated", 
                                "ntl_aggregated_by_time_period.Rds"))
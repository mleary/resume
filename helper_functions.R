#author: matt leary
#date:11/10/2019
#intent: helper functions for resume built with R pagedown

library(dplyr)
library(ggplot2)
library(tidyr)
library(purrr)

# Construct a bar chart of skills
build_skill_bars <- function(skill_data, section_title) {
  skill_data %>%  
    filter(section == section_title) %>% 
    ggplot(aes(x= reorder(skill, level), y = 5)) +
    geom_col(fill = "lightgrey") +
    geom_col(aes(x= reorder(skill, level), y = level), fill = "darkgrey") +
    coord_flip() +
    geom_text(aes(label = skill,  y = 0.25), hjust = 0, size = 12, color = "white") +
    expand_limits(y = c(0,5)) +
    labs(x = NULL,
         y = NULL) + 
    theme_void() +
    theme(panel.background = element_rect(fill = "transparent", colour = NA),
          plot.background  = element_rect(fill = "transparent", colour = NA)) 
}


# Take a position dataframe and the section id desired
# and prints the section to markdown. 
print_section <- function(position_data, section_id){
  position_data %>% 
    filter(section == section_id &
          include == TRUE) %>% 
    arrange(desc(end)) %>% 
    mutate(id = 1:n()) %>% 
    pivot_longer(
      starts_with('description'),
      names_to = 'description_num',
      values_to = 'description'
    ) %>% 
    filter(!is.na(description) | description_num == 'description_1') %>%  ### work on this
    group_by(id) %>% 
    mutate(
      descriptions = list(description),
      no_descriptions = is.na(first(description))
    ) %>% 
    ungroup() %>% 
    filter(description_num == 'description_1') %>% 
    mutate(
      timeline = ifelse(
        is.na(start) | start == end,
        end,
        glue('{end} - {start}')
      ),
      description_bullets = ifelse(
        no_descriptions,
        ' ',
        map_chr(descriptions, ~paste('-', ., collapse = '\n'))
      )
    ) %>% 
    # strip_links_from_cols(c('title', 'description_bullets')) %>%
    mutate_all(~ifelse(is.na(.), 'N/A', .)) %>% 
    glue_data(
      "### {title}",
      "\n\n",
      "{institution}",
      "\n\n",
      "{loc}",
      "\n\n",
      "{timeline}", 
      "\n\n",
      "{description_bullets}",
      "\n\n\n",
    )
}
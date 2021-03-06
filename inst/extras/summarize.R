
stop("should we get here ever")

df.preprocessed <- df
df.orig <- df.orig[df.preprocessed$original_row,]

if (!all(df.preprocessed$original_row == df.orig$original_row)) {stop("Match df.preprocessed and df.orig")}

print("Write summaries of field entries and count stats for all fields")

for (field in setdiff(names(df.preprocessed), c(names(df.preprocessed)[grep("language", names(df.preprocessed))], "row.index", "paper", "publication_decade", "publication_year", "pagecount", "obl", "obl.original", "original_row", "dissertation", "synodal", "original", "unity", "author_birth", "author_death", "gatherings.original", "width.original", "height.original", "longitude", "latitude", "page", "item", "publisher.printedfor", "publisher"))) {

  print(field)

  print("Accepted entries in the preprocessed data")
  s <- write_xtable(df.preprocessed[[field]], file = paste(output.folder, field, "_accepted.csv", sep = ""), count = TRUE)

  print("Discarded entries")
  if ((field %in% names(df.preprocessed)) && (field %in% names(df.orig))) {
    inds <- which(is.na(df.preprocessed[[field]]))
    original <- as.vector(na.omit(as.character(df.orig[[field]][inds])))
    tmp <- write_xtable(original, paste(output.folder, field, "_discarded.csv", sep = ""), count = TRUE)
  }

  print("Successful nontrivial conversions")
  if (field %in% names(df.preprocessed) && (field %in% names(df.orig)) && !field == "dimension") {
    inds <- which(!is.na(df.preprocessed[[field]]))
    original <- as.character(df.orig[[field]][inds])
    polished <- as.character(df.preprocessed[[field]][inds])
    tab <- cbind(original = original, polished = polished)
    # Exclude trivial cases (original == polished exluding cases)
    #tab <- tab[!tab[, "original"] == tab[, "polished"], ]
    tab <- tab[!tolower(tab[, "original"]) == tolower(tab[, "polished"]), ]
    tmp <- write_xtable(tab, paste(output.folder, field, "_conversions_nontrivial.csv", sep = ""), count = TRUE)
  }
}



print("Conversion summaries")
originals <- c(publisher = "publisher",
	       pagecount = "physical_extent",
	       publication_place = "publication_place",
	       country = "publication_place",
	       publication_year = "publication_time",
	       author = "author_name",
	       author_gender = "author_name"
	       #title = "title"	# Very large summaries
	       )
for (nam in names(originals)) {
  o <- as.character(df.orig[[originals[[nam]]]])
  x <- as.character(df.preprocessed[[nam]])
  inds <- which(!is.na(x) & !(tolower(o) == tolower(x)))
  tmp <- write_xtable(cbind(original = o[inds],
      	 		    polished = x[inds]),
    paste(output.folder, paste(nam, "conversion_nontrivial.csv", sep = "_"), sep = ""))

}

print("Accept summaries")
for (nam in names(originals)) {
  x <- as.character(df.preprocessed[[nam]])
  tmp <- write_xtable(x,
    paste(output.folder, paste(nam, "accepted.csv", sep = "_"), sep = ""))

}

print("Discard summaries")
for (nam in names(originals)) {
  o <- as.character(df.orig[[originals[[nam]]]])
  x <- as.character(df.preprocessed[[nam]])
  inds <- which(is.na(x))
  tmp <- write_xtable(o[inds],
    paste(output.folder, paste(nam, "discarded.csv", sep = "_"), sep = ""),
    count = TRUE)

}

print("Automated summaries done.")

# Authors with missing life years
tab <- df.preprocessed %>% filter(!is.na(author_name) & (is.na(author_birth) | is.na(author_death))) %>% select(author_name, author_birth, author_death)
tmp <- write_xtable(tab, file = paste(output.folder, "authors_missing_lifeyears.csv", sep = ""))

# Ambiguous authors with many birth years
births <- split(df.preprocessed$author_birth, df.preprocessed$author_name)
births <- births[sapply(births, length) > 0]
many.births <- lapply(births[names(which(sapply(births, function (x) {length(unique(na.omit(x)))}) > 1))], function (x) {sort(unique(na.omit(x)))})
dfs <- df.preprocessed[df.preprocessed$author_name %in% names(many.births), c("author_name", "author_birth", "author_death")]
dfs <- unique(dfs)
dfs <- dfs %>% arrange(author_name, author_birth, author_death)
write.table(dfs, paste(output.folder, "author_life_ambiguous.csv", sep = ""), quote = F, sep = "\t", row.names = FALSE)

# Undefined language
tmp <- write_xtable(as.character(df.orig$language[df.preprocessed$language.undetermined]), filename = "output.tables/language_unidentified.csv")

# No country mapping
tmp <- write_xtable(as.character(df.preprocessed$publication_place[is.na(df.preprocessed$country)]), filename = "output.tables/publication_place_missingcountry.csv")

# TODO conversion tables can be automatized
tab <- cbind(original = df.orig$physical_extent, df.preprocessed[, c("pagecount", "volnumber", "volcount")])
tmp <- write_xtable(tab, filename = "output.tables/conversions_physical_extent.csv")

tab <- cbind(original = df.orig$physical_dimension, df.preprocessed[, c("gatherings.original", "width.original", "height.original", "obl.original", "gatherings", "width", "height", "obl", "area")])
tmp <- write_xtable(tab, filename = "output.tables/conversions_physical_dimension.csv")

# -----------------------------------------------------

print("Write the mapped author genders in tables")
tab <- data.frame(list(name = df.preprocessed$author,
       		     gender = df.preprocessed$author_gender))
tab <- tab[!is.na(tab$gender), ] # Remove NA gender

write_xtable(subset(tab, gender == "male")[,-2], file = paste(output.folder, "gender_male.csv", sep = ""))
write_xtable(subset(tab, gender == "female")[,-2], file = paste(output.folder, "gender_female.csv", sep = ""))
write_xtable(unname(pick_firstname(df.preprocessed$author_name)[is.na(df.preprocessed$author_gender)]), file = paste(output.folder, "gender_unknown.csv", sep = ""))

# ----------------------------------------------------

# TODO remove from here
#print("Average pagecounts")
#mean.pagecounts.multivol <- mean_pagecounts(filter(df.preprocessed, multivol))
#mean.pagecounts.singlevol <- mean_pagecounts(filter(df.preprocessed, singlevol)) 
#mean.pagecounts.issue <- mean_pagecounts(filter(df.preprocessed, issue)) 
#mean.pagecounts <- full_join(mean.pagecounts.singlevol, mean.pagecounts.multivol, by = "doc.dimension")
#mean.pagecounts <- full_join(mean.pagecounts, mean.pagecounts.issue, by = "doc.dimension")
#mean.pagecounts$doc.dimension <- factor(mean.pagecounts$doc.dimension, levels = levels(mean.pagecounts.singlevol$doc.dimension#))
#write.table(mean.pagecounts, file = paste(output.folder, "mean_page_counts.csv", sep = ""), quote = F, row.names = F, sep = ",")

print("Write places with missing geolocation to file")
tab <- rev(sort(table(df.preprocessed$publication_place[is.na(df.preprocessed$latitude) | is.na(df.preprocessed$longitude)])))
tab <- tab[tab > 0]
tab <- cbind(names(tab), tab)
colnames(tab) <- c("name", "count")
write.table(tab, file = paste(output.folder, "absentgeocoordinates.csv", sep = ""), quote = F, row.names = F, sep = "\t")



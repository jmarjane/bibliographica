### Technical

 * polish_years "6-1939", "19-19", "19765-19765", "20021" ja "19920831-19920831"

 * Use tm pkg: removeNumbers; removePuncuations; removeWords;
   replaceWords; stripWhiteSpace; tmTolower; and tau:remove_stopwords;
   stopwords(language = ...)

 * Travis & automated analysis updates on a public (non-github)
   server, for instance Pouta.

 * Add automated field conversion map from original to final names
   (with multiplication) and also which fields are in the data but not
   yet preprocessed

 * read_mapping -> Use the fast = TRUE more - at least for slower
   polishing function

 * Move all unit tests to tables that can be linked from the overview
   page. As already done with publicationplaces.Rmd

 * Lisää README-fileihin tai summarymarkdowneihin viitteet nimi- ja
   gendertietokannosita ym ulkoisista datoista


### Dimensions

  * Compare ready made sheets and calculated estimates; these have
    notable differences, why?
  * Augment missing values using our estimates, not the ready made sheet 
  * Account for year and publication place if feasible as the sizes may vary


### Publication time

There are now many docs (ESTC 4000) where publication year is before
author birth. These are removed in bibliographica/R/validation.R. We
need to check in more detail what the reasons are, if there is
anything systematic.

The [discarded publication
names](https://github.com/rOpenGov/fennica/blob/master/inst/examples/output.tables/publication_year_discarded.csv)
include terms such as '184?'. These could be however added in
publication_decade field to include all possible information in
decadal analysis. And then include in conversion summaries the
original, year, and decade.

test_polish_years still has some unresolved cases


### Author names

VIAF. Iso auktoritietokanta ja linkittää monesta paikkaa. Onko
mahiksia yrittää yhdistää tätä liittyen sekä auktoreihin että
julkaisijoihin? MARC-pohjainen systeemi.

Test and validate place / person name clusterings. Could greatly
facilitate analysis with new names but validation and error estimates
are needed. Now we have gathered good ground truth lists so should be
possible.

Sukunimet ?  http://en.wikipedia.org/wiki/Wikipedia:Persondata (From
the XML dump) wikipediasta voisi periaatteessa ottaa yhdestä
datadumpista kaikki henkilödatan joka pitää kaiketi sisällään kaikki
wikipedian henkilöt? Ideaalitilanne jokaisesta henkilöstä voitaisiin
vetää linkki wikipediaan ja vastavuoroisesti sieltä meidän
systeemeihin. kun lopulta syntyvää kirjastojärjestelmää käytetään
hyväksi muuhun kuin tilastollisiin juttuihin.

 * If you’re considering an analysis based on author name, you may
   find the humaniformat (for extraction of first names) package
   useful. Has format_reverse function for reversing “Last, First”
   names.

Kattelen myös jos auktoreista löytyy esim. joku oclc auktorifile jossa
olisi eri tyyppien nimien kirjoittamisen eri muodot listattuna. Pitäis
olla.


### Author info

 * [gutenbergr R package](https://cran.rstudio.com/web/packages/gutenbergr/vignettes/intro.html) contains metadata for ~50,000 Gutenberg documents and ~ 16,000 authors (life years, aliases etc) 

 * It might be very useful to separate metadata of the places and
   persons from the document metadata. This would save space and
   promote modularity and reuse.

 * You could match the wikipedia column in gutenberg_author to
   Wikipedia content with the WikipediR package or to pageview
   statistics with the wikipediatrend package


### Geography

Test the [tmap](https://cran.r-project.org/web/packages/tmap/vignettes/tmap-nutshell.html) R package

Fennica geo enrich brings in geocoordinates to many new places. Could
be incorporated in the main pipeline already to simplify things.

Several GIS coordinates for obvious places missing at least for estc.

The [opencage R
package](https://cran.r-project.org/web/packages/opencage/vignettes/opencage.html)
and [https://github.com/ropenscilabs/opencage](see also this link) can be added
to get more place-geocode mappings

Consider adding country acronyme in the end of all place names.

Recognize potentially ambiguous placename-country mapping
automatically for instance with geoname data or another similar
source/s. Then manually decide which country to use by default in each
case. Also identify potential ambiguous places (for instance those
that have common first part which may sometimes occur alone).

Saako kaupunki-maa mäppäykset tietokannoista. Optioita:

1) [open geocode
   database](http://www.opengeocode.org/download.php#cities) Cities of
   the World näyttää tosi kattavalta, laajempi kuin se aikaisemmin
   lähettämäni ja on puhtaasti open source. Lisäksi noita muita
   sovelluksia on mukavasti.

2) map towns to gis coordinates, then gis to country

3) geonames: Geonamesista löysin seuraavan aika hyvin asettuvan johon
   listattuna aika kattavan oloisesti kaikki paikat joissa yli 15k
   asukasta. Tämä voisi olla aika hyvä? Samalla sieltä löytyisi
   kaikenlaista lisätietoa paikkoihin liittyen, maakoodit standardeina
   jne. Eli varmaan sitten myöhemmin jos tehdään myös karttoja joissa
   eri elementtejä niin tästä voisi olla hyötyä?

4) World Cities Database https://www.maxmind.com/en/worldcities
  Includes city, region, country, latitude and longitude and
  Population. A listing of all the cities in the world. This database
  contains duplicate and incorrect entries. It is provided as-is, and
  we are unable to provide support for it. For a cleaner database, try
  GeoNames, but they may lack some cities included in our data. This
  could be useful for initial city-county mappings and place name
  validation however.

Muita Usein mainittuja mäppäysresursseja:
- Open Street Map
- Yahoo's GeoPlanet provides a dataset of all named places on earth,
  including oceans, countries, cities and villages. You can download
  it at http://developer.yahoo.com/geo/geoplanet/data/
- GeoDataSource http://www.geodatasource.com/world-cities-database/free


### Utilities

Open example data set to be used with our tools (ESTC subset)

Testaa networkD3-visuja, hyviä ja varmaan relevantteja:
http://christophergandrud.github.io/networkD3/

Data Table: http://rstudio.github.io/DT/

Poudan R-serverille interaktiivisia yhteenvetoja.
- rGoogleViz
- Shiny
- muut R:n interaktiiviset paketit...

Animaatiot

### Subject classes

 * Melvil Decimal System_ http://www.librarything.com/mds/0
 * Dewey Decimal System: promised for us as a dump
 * Library of Congress Catalogue: see also [gutenbergr R
   package](https://cran.rstudio.com/web/packages/gutenbergr/vignettes/intro.html) which
   contains metadata for ~50,000 Gutenberg documents including Library
   of Congress subject heading classificatoins for the documents.


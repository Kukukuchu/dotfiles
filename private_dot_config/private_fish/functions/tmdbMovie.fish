function tmdbMovie
  https -A bearer -a "$TMDBBearer" "api.themoviedb.org/3/movie/$argv[1]" \
    append_to_response==keywords,credits,reviews,recommendations,similar \
    language==en-US \
    $argv[2..-1]
end

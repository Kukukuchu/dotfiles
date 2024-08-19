function tmdbTop
  https -A bearer -a "$TMDBBearer" 'api.themoviedb.org/3/discover/movie' \
    include_adult==false \
    include_video==false \
    language==en-US \
    page==$argv[1] \
    sort_by==vote_average.desc \
    without_genres==99,10755 \
    vote_count.gte==200 \
    with_original_language=='xx|en|ja|ko|cn|zh|az|cs|da|de|es|fi|fr|sh|hr|hu|is|it|ka|nl|nb|no|pl|pt|ro|ru|sr|sv|tr|uk' \
    $argv[2..-1]
end

def path_to(page_name, model_id=nil)
    case page_name

      when /the homepage/
        root_path
      when /new player/
        new_player_path
      when /the list of games/
        games_path
      end
end

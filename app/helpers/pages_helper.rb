module PagesHelper
  IMAGES = {
    'player-guide' => 'show/fish.jpg',
    'playing-tips' => 'show/fish.jpg',
    'press' => 'show/hero.jpg',
    'faqs' => 'show/arab_spring.jpg',
    'awards' => 'show/jellyfish.jpg',
    'preparation' => 'show/preparation.jpg',
    'd12-prep' => 'show/flying.jpg',
    'opening-round' => 'show/climate_crime.jpg',
    'closing-round' => 'show/Turkey-Protest_Horo-13.jpg',
    'organiser-une-action-pas-a-pas' => 'show/planning_notes.png',
    'response-to-the-recent-attacks' => 'show/resist.jpg'
  }

  def header_image(page)
    if page && IMAGES.keys.include?(page.slug_key)
      IMAGES[page.slug_key]
    else
      'home/swarm.jpg'
    end
  end
end
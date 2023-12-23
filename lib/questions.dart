class AnimeQuestion {
  final String animeTitle;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  AnimeQuestion({
    required this.animeTitle,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

List<AnimeQuestion> animeQuestions = [
  //Naruto
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is the protagonist of Naruto?",
    options: [
      "Sasuke Uchiha",
      "Naruto Uzumaki",
      "Sakura Haruno",
      "Kakashi Hatake"
    ],
    correctAnswerIndex: 1, // Index of the correct answer in options list
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What is Naruto's ultimate goal?",
    options: [
      "To become Hokage",
      "To become the strongest ninja",
      "To destroy the Hidden Leaf Village",
      "To find a legendary weapon"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is Naruto's father?",
    options: [
      "Jiraiya",
      "Tobirama Senju",
      "Minato Namikaze",
      "Hiruzen Sarutobi"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What type of creature is Kurama?",
    options: ["A giant toad", "A dragon", "A phoenix", "A tailed beast"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is known as the 'Copy Ninja'?",
    options: ["Kakashi Hatake", "Itachi Uchiha", "Madara Uchiha", "Orochimaru"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Which character has the ability to control sand?",
    options: ["Sasuke Uchiha", "Neji Hyuga", "Rock Lee", "Gaara"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What is Sasuke's clan known for?",
    options: [
      "Shadow manipulation",
      "Fire release",
      "Ice release",
      "Lightning release"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is Naruto's mother?",
    options: ["Kushina Uzumaki", "Tsunade", "Mei Terumi", "Rin Nohara"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What is the name of the village where Naruto was born?",
    options: [
      "The Hidden Sand Village",
      "The Hidden Sound Village",
      "The Hidden Leaf Village",
      "The Hidden Mist Village"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is Naruto's teacher?",
    options: ["Jiraiya", "Kakashi Hatake", "Orochimaru", "Minato Namikaze"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is Naruto's best friend?",
    options: ["Sasuke Uchiha", "Shikamaru Nara", "Neji Hyuga", "Rock Lee"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What clan does Sasuke belong to?",
    options: ["Hyuga Clan", "Senju Clan", "Aburame Clan", "Uchiha Clan"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Which Uchiha has the weakest vision?",
    options: [
      "Sarada Uchiha",
      "Itachi Uchiha",
      "Obito Uchiha",
      "Sasuke Uchiha"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What is the name of the giant toad that Naruto often summons?",
    options: ["Gamabunta", "Manda", "Katsuyu", "Giant Panda"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Which character has the ability to control insects?",
    options: [
      "Kiba Inuzuka",
      "Shino Aburame",
      "Choji Akimichi",
      "Shikamaru Nara"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is the son of Minato Namikaze and Kushina Uzumaki?",
    options: [
      "Sasuke Uchiha",
      "Naruto Uzumaki",
      "Itachi Uchiha",
      "Boruto Uzumaki"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Which character is known for using medical ninjutsu?",
    options: ["Hinata Hyuga", "Tsunade", "Ino Yamanaka", "Temari"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "What is the name of Naruto's son?",
    options: ["Sasuke Uchiha", "Minato Namikaze", "Boruto Uzumaki", "Gaara"],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Naruto",
    question: "Who is the leader of the Akatsuki organization?",
    options: ["Itachi Uchiha", "Kisame Hoshigaki", "Pain", "Madara Uchiha"],
    correctAnswerIndex: 2,
  ),
  //Attack on titan
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question:
        "What are the giant humanoid creatures in Attack on Titan called?",
    options: ["Giants", "Titans", "Colossals", "Eldians"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who is known as the 'Armored Titan'?",
    options: ["Eren Yeager", "Reiner Braun", "Levi Ackerman", "Armin Arlert"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "What is the name of Eren's adoptive sister?",
    options: ["Mikasa Ackerman", "Sasha Blouse", "Annie Leonhart", "Hange Zoë"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who is the leader of the Scout Regiment?",
    options: ["Erwin Smith", "Kenny Ackerman", "Dot Pixis", "Rod Reiss"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "What is the name of Eren's titan form?",
    options: [
      "Armored Titan",
      "Colossal Titan",
      "Female Titan",
      "Attack Titan"
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who killed Eren's mother in the series?",
    options: ["Reiner Braun", "Zeke Yeager", "Annie Leonhart", "Dina Yeager"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "What is the name of the city where the story begins?",
    options: ["Shiganshina", "Trost", "Wall Maria", "Stohess"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who was the female titan in the series?",
    options: [
      "Mikasa Ackerman",
      "Historia Reiss",
      "Annie Leonhart",
      "Pieck Finger"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Which titan has the ability to harden its skin?",
    options: ["Armored Titan", "Beast Titan", "Colossal Titan", "Jaw Titan"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who was the leader of the Beast Titan?",
    options: [
      "Reiner Braun",
      "Kenny Ackerman",
      "Zeke Yeager",
      "Bertolt Hoover"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who is known as the 'Colossal Titan'?",
    options: ["Reiner Braun", "Eren Yeager", "Bertolt Hoover", "Zeke Yeager"],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Which titan killed Marco Bott?",
    options: ["Colossal Titan", "Armored Titan", "Female Titan", "Beast Titan"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "What is the name of Eren's father?",
    options: ["Rod Reiss", "Kenny Ackerman", "Uri Reiss", "Grisha Yeager"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question:
        "What is the name of the mysterious substance that hardens Titans?",
    options: ["Titanite", "Hardened Titanite", "Titanium", "Hardening"],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who was the true royal family inside the Walls?",
    options: ["Reiss", "Ackerman", "Yeager", "Smith"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question:
        "What is the name of the military branch that protects the king directly?",
    options: [
      "Garrison Regiment",
      "Military Police Brigade",
      "Scout Regiment",
      "Survey Corps"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Which titan was used to breach Wall Maria in the series?",
    options: ["Armored Titan", "Female Titan", "Colossal Titan", "Beast Titan"],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who was the first character to inherit the Female Titan power?",
    options: [
      "Mikasa Ackerman",
      "Historia Reiss",
      "Annie Leonhart",
      "Sasha Blouse"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "What is the name of Eren's hometown?",
    options: ["Trost", "Karanes", "Shiganshina", "Utopia"],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Attack on Titan",
    question: "Who trained Eren, Mikasa, and Armin to fight titans?",
    options: ["Captain Levi", "Commander Erwin", "Hange Zoë", "Dot Pixis"],
    correctAnswerIndex: 0,
  ),

  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the main protagonist's name in Demon Slayer?",
    options: [
      "Tanjiro Kamado",
      "Zenitsu Agatsuma",
      "Inosuke Hashibira",
      "Giyu Tomioka"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Who is Tanjiro's younger sister?",
    options: [
      "Nezuko Kamado",
      "Kanao Tsuyuri",
      "Shinobu Kocho",
      "Mitsuri Kanroji"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of Tanjiro's breathing technique?",
    options: [
      "Water Breathing",
      "Sun Breathing",
      "Flame Breathing",
      "Wind Breathing"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Who is the main antagonist in Demon Slayer?",
    options: ["Rui", "Muzan Kibutsuji", "Akaza", "Enmu"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What does Tanjiro aspire to do?",
    options: [
      "Join the Demon Slayer Corps",
      "Cure his sister",
      "Find the strongest demon",
      "Avenge his family"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Which demon slayer uses the Thunder Breathing technique?",
    options: [
      "Inosuke Hashibira",
      "Zenitsu Agatsuma",
      "Tengen Uzui",
      "Giyu Tomioka"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Who is the Water Hashira?",
    options: [
      "Shinobu Kocho",
      "Mitsuri Kanroji",
      "Giyu Tomioka",
      "Muichiro Tokito"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of Zenitsu's companion?",
    options: [
      "Nezuko Kamado",
      "Tanjiro Kamado",
      "Kanao Tsuyuri",
      "Inosuke Hashibira"
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Who is the main demon in the Spider Demon family?",
    options: ["Akaza", "Enmu", "Rui", "Kokushibo"],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of the Demon Slayer Corps' leader?",
    options: [
      "Kanae Kocho",
      "Muzan Kibutsuji",
      "Yoriichi Tsugikuni",
      "Kagaya Ubuyashiki",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of Tanjiro's mentor?",
    options: [
      "Tengen Uzui",
      "Sakonji Urokodaki",
      "Kyojuro Rengoku",
      "Sanemi Shinazugawa"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What color are Nezuko's eyes when she is a demon?",
    options: ["Red", "Blue", "Green", "Black"],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Which breathing style does Inosuke use?",
    options: [
      "Beast Breathing",
      "Wind Breathing",
      "Flame Breathing",
      "Water Breathing"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Who is the Flame Hashira?",
    options: [
      "Sanemi Shinazugawa",
      "Kyojuro Rengoku",
      "Giyu Tomioka",
      "Tengen Uzui"
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Which demon possesses a drum?",
    options: ["Rui", "Kyogai", "Akaza", "Enmu"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of the final arc in the anime movie?",
    options: [
      "Demon Train Arc",
      "Red Light District Arc",
      "Mugen Train Arc",
      "Infinity Castle Arc"
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of the Demon Slayer Corps' crow?",
    options: ["Hakase", "Chuntaro", "Sabito", "Muzan"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "Who is the Sound Hashira?",
    options: [
      "Tengen Uzui",
      "Gyomei Himejima",
      "Muichiro Tokito",
      "Sanemi Shinazugawa"
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of Zenitsu's sword?",
    options: ["Aoi", "Chuntaro", "Nezuko", "Tsugikuni"],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Demon Slayer",
    question: "What is the name of the opening theme song?",
    options: ["Gurenge", "Homura", "Kamado Tanjiro no Uta", "From the Edge"],
    correctAnswerIndex: 0,
  ),

  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is the captain of the Straw Hat Pirates?",
    options: [
      "Monkey D. Luffy",
      "Roronoa Zoro",
      "Usopp",
      "Nami",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Luffy's signature attack?",
    options: [
      "Gum-Gum Pistol",
      "Red Hawk",
      "Jet Gatling",
      "Gum-Gum Elephant Gun",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is the cook of the Straw Hat Pirates?",
    options: [
      "Sanji",
      "Franky",
      "Brook",
      "Chopper",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Zoro's sword?",
    options: [
      "Sandai Kitetsu",
      "Yubashiri",
      "Shusui",
      "Wado Ichimonji",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is known as the 'Pirate Hunter'?",
    options: [
      "Sanji",
      "Usopp",
      "Nami",
      "Zoro",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is Luffy's idol and a former pirate king?",
    options: [
      "Gol D. Roger",
      "Silvers Rayleigh",
      "Shanks",
      "Whitebeard",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Luffy's ship?",
    options: [
      "Red Force",
      "Thousand Sunny",
      "Moby Dick",
      "Going Merry",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who ate the Gomu Gomu no Mi?",
    options: [
      "Sanji",
      "Nami",
      "Zoro",
      "Luffy",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is the doctor of the Straw Hat Pirates?",
    options: [
      "Robin",
      "Chopper",
      "Franky",
      "Brook",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is the sniper of the Straw Hat Pirates?",
    options: [
      "Franky",
      "Robin",
      "Usopp",
      "Brook",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is Luffy's grandfather?",
    options: [
      "Whitebeard",
      "Garp",
      "Kizaru",
      "Roger",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Nami's signature attack?",
    options: [
      "Tornado Tempo",
      "Cyclone Baton",
      "Thunder Lance Tempo",
      "Mirage Tempo",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is known as the 'King of Snipers'?",
    options: [
      "Van Augur",
      "Yasopp",
      "Beckman",
      "Usopp",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who has the ability to transform into a phoenix?",
    options: [
      "Ace",
      "Law",
      "Marco",
      "Jinbe",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Zoro's teacher?",
    options: [
      "Mihawk",
      "Rayleigh",
      "Kizaru",
      "Koshiro",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Luffy's father?",
    options: [
      "Roger",
      "Garp",
      "Dragon",
      "Whitebeard",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is the owner of the Baratie?",
    options: [
      "Zeff",
      "Buggy",
      "Arlong",
      "Krieg",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "What is the name of Zoro's rival?",
    options: [
      "Mihawk",
      "Law",
      "Kaido",
      "Kid",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question: "Who is the owner of the Straw Hat?",
    options: [
      "Roger",
      "Shanks",
      "Garp",
      "Rayleigh",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Piece",
    question:
        "What is the name of the mystical treasure sought by many pirates?",
    options: [
      "Red Line",
      "One Piece",
      "Grand Line",
      "All Blue",
    ],
    correctAnswerIndex: 1,
  ),

  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "Who is the protagonist of Jujutsu Kaisen?",
    options: [
      "Nobara Kugisaki",
      "Megumi Fushiguro",
      "Satoru Gojo",
      "Yuji Itadori",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the cursed object that Yuji swallows?",
    options: [
      "Finger",
      "Sword",
      "Coin",
      "Necklace",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "Who is the mentor of Yuji Itadori?",
    options: [
      "Suguru Geto",
      "Nobara Kugisaki",
      "Satoru Gojo",
      "Megumi Fushiguro",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the cursed technique used by Megumi Fushiguro?",
    options: [
      "Shadow Manipulation",
      "Domain Expansion",
      "Sorcery",
      "Cursed Energy Manipulation",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "Who is the main antagonist in Jujutsu Kaisen?",
    options: [
      "Ryomen Sukuna",
      "Satoru Gojo",
      "Suguru Geto",
      "Yuta Okkotsu",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the name of the jujutsu high school?",
    options: [
      "Kyoto School of Sorcery",
      "Tokyo Metropolitan Curse Technical College",
      "Osaka Institute of Curses",
      "Fukui Academy of Cursed Arts",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the type of curse Yuji Itadori has within him?",
    options: [
      "Infinity Curse",
      "Sukuna's Curse",
      "Shadow Curse",
      "Ephemeral Curse",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "Who is the first-year student with cursed speech?",
    options: [
      "Maki Zenin",
      "Toge Inumaki",
      "Panda",
      "Kasumi Miwa",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question:
        "What is the name of the cursed object that amplifies cursed energy?",
    options: [
      "Black Rope",
      "Resonance Cursed Object",
      "Cursed Womb: Death Painting",
      "Inverse Cursed Sphere",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question:
        "Who is the principal of Tokyo Metropolitan Curse Technical College?",
    options: [
      "Satoru Gojo",
      "Kiyotaka Ijichi",
      "Masamichi Yaga",
      "Suguru Geto",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question:
        "Who is the cursed spirit that killed Yuji Itadori's grandfather?",
    options: [
      "Mahito",
      "Jogo",
      "Sukuna",
      "Dagon",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the name of the cursed tool used to confine curses?",
    options: [
      "Binding Vow",
      "Cursed Prison",
      "Coffin of Eternal Rest",
      "Sealed Shrine",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question:
        "Who is the girl with immense cursed energy and a connection to Sukuna?",
    options: [
      "Mai Zenin",
      "Maki Zenin",
      "Mai Mashiro",
      "Mai Kusakabe",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the technique used by Satoru Gojo to manipulate space?",
    options: [
      "Purple",
      "Crimson",
      "Blue",
      "Infinity",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question:
        "Who is the first-year student with the ability to control and manipulate the Earth?",
    options: [
      "Toge Inumaki",
      "Maki Zenin",
      "Panda",
      "Mechamaru",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the name of Megumi Fushiguro's shikigami?",
    options: [
      "Nue",
      "Zenko",
      "Kuchisake-onna",
      "Ittan-momen",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "Who is the sorcerer known as the 'Death Painting Womb'?",
    options: [
      "Mahito",
      "Jogo",
      "Dagon",
      "Hanami",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "What is the ability of Panda?",
    options: [
      "Super Strength",
      "Sorcery",
      "Healing",
      "Communicating with Animals",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question:
        "What is the name of the event where students showcase their abilities?",
    options: [
      "Cursed Games",
      "Jujutsu Expo",
      "Culling Game",
      "Goodwill Event",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "Jujutsu Kaisen",
    question: "Who is the head of the Zenin Clan?",
    options: [
      "Maki Zenin",
      "Naoya Zenin",
      "Ogi Zenin",
      "Toji Zenin",
    ],
    correctAnswerIndex: 1,
  ),

  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What is the real name of Saitama, the protagonist?",
    options: [
      "Saitama",
      "Boros",
      "Genos",
      "Caped Baldy",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the hero ranked second in the Hero Association?",
    options: [
      "Bang",
      "Tatsumaki",
      "King",
      "Fubuki",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What is the name of the cyborg who is Saitama's disciple?",
    options: [
      "Mumen Rider",
      "Silver Fang",
      "Atomic Samurai",
      "Genos",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question:
        "Who is the strongest man on Earth in the One Punch Man universe?",
    options: [
      "Genos",
      "Mumen Rider",
      "Metal Knight",
      "King",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What is the hero name of Saitama?",
    options: [
      "Caped Baldy",
      "One Punch Man",
      "Bald Cape",
      "Punch Hero",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the leader of the Hero Association?",
    options: [
      "Tatsumaki",
      "Bang",
      "Metal Knight",
      "Child Emperor",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What is the name of the Hero Association's headquarters?",
    options: [
      "A-City",
      "Z-City",
      "S-City",
      "H-City",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What is the name of the alien conqueror defeated by Saitama?",
    options: [
      "Lord Boros",
      "Deep Sea King",
      "Vaccine Man",
      "Gouketsu",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What was Saitama's daily hero routine?",
    options: [
      "100 push-ups, 100 sit-ups, 100 squats, 10 km running",
      "100 push-ups, 100 sit-ups, 100 squats, 10 km cycling",
      "100 crunches, 100 pull-ups, 10 km running, 100 squats",
      "100 push-ups, 100 pull-ups, 100 squats, 10 km running",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the hero known for his incredible luck?",
    options: [
      "Genos",
      "King",
      "Snek",
      "Metal Bat",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the hero known for his incredible luck?",
    options: [
      "Genos",
      "King",
      "Snek",
      "Metal Bat",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the top-ranked S-Class hero in the Hero Association?",
    options: [
      "Tornado of Terror",
      "Blast",
      "Silver Fang",
      "King",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Which hero is known as the 'Demon Cyborg'?",
    options: [
      "King",
      "Saitama",
      "Genos",
      "Atomic Samurai",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the founder of the Hero Association?",
    options: [
      "Saitama",
      "Blast",
      "Metal Knight",
      "Agoni",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is known as the 'Caped Baldy'?",
    options: [
      "Genos",
      "Saitama",
      "King",
      "Mumen Rider",
    ],
    correctAnswerIndex: 1,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "What is Saitama's signature move?",
    options: [
      "Serious Punch",
      "Consecutive Normal Punches",
      "Killer Move: Serious Table Flip",
      "Serious Series: Serious Side Hops",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question:
        "What is the name of the martial arts master who taught Bang and Bomb?",
    options: [
      "Silver Fang",
      "Silver Samurai",
      "Silver Fang Bang",
      "Silver Fang Bomb",
    ],
    correctAnswerIndex: 0,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the only hero known to have wounded Saitama?",
    options: [
      "Genos",
      "Boros",
      "Garou",
      "Metal Knight",
    ],
    correctAnswerIndex: 2,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question:
        "What is the name of the monster that nearly killed Garou during his childhood?",
    options: [
      "Watchdog Man",
      "Black Sperm",
      "Orochi",
      "Overgrown Rover",
    ],
    correctAnswerIndex: 3,
  ),
  AnimeQuestion(
    animeTitle: "One Punch Man",
    question: "Who is the creator of the Hero Association in One Punch Man?",
    options: [
      "Dr. Kuseno",
      "Dr. Genus",
      "Bofoi",
      "Agoni",
    ],
    correctAnswerIndex: 3,
  ),
];

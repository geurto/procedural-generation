class CyberpunkPalette {
  ArrayList<Integer> colours = new ArrayList<Integer>();
  
  CyberpunkPalette() {
    colours.add(color(2, 3, 23));
    colours.add(color(2, 15, 67));
    colours.add(color(3, 38, 128));
    colours.add(color(25, 66, 172));
    colours.add(color(29, 111, 255));
    colours.add(color(0, 216, 255));
    colours.add(color(207, 235, 255));
    colours.add(color(255, 123, 225));
    colours.add(color(254, 59, 240));
    colours.add(color(99, 69, 251));
  
    colours.add(color(27, 4, 19));
    colours.add(color(34, 26, 65));
    //colours.add(color(72, 14, 36));
    //colours.add(color(115, 1, 35));
    colours.add(color(223, 5, 17));
    colours.add(color(255, 65, 139));
    colours.add(color(116, 98, 158));
    colours.add(color(86, 60, 107));
    colours.add(color(2, 201, 255));
    colours.add(color(191, 243, 255));
    colours.add(color(0, 91, 162));
    colours.add(color(14, 35, 78));
    colours.add(color(21, 3, 19));
  }
}

class SunrisePalette {
  ArrayList<Integer> colours = new ArrayList<Integer>();
  
  SunrisePalette() {
    // Sunrise In The City: https://www.schemecolor.com/sunrise-in-the-city.php
    //colours.add(color(62, 74, 112));   // Police Blue
    //colours.add(color(86, 101, 142));  // UCLA Blue
    //colours.add(color(255, 153, 120)); // Light Salmon
    //colours.add(color(254, 176, 110)); // Very Light Tangelo
    //colours.add(color(152, 115, 123)); // Bazaar
    //colours.add(color(107, 99, 123));  // Old Lavender
    
    // Carribean Sunrise: https://www.schemecolor.com/caribbean-sunrise.php
    colours.add(color(15, 56, 102));   // Midnight Blue
    colours.add(color(229, 174, 31));  // Uroblin
    colours.add(color(225, 131, 48));  // Cadmium Orange
    colours.add(color(36, 104, 124));  // Blue Sapphire
    colours.add(color(62, 147, 136));  // Zomp
    colours.add(color(110, 166, 138)); // Polished Pine
    
    // Bonus: red for accents
    colours.add(color(223, 5, 17));

  }
}

{ pkgs, ... }: {
  programs.autorandr = {
    enable = true;
    profiles = {
      "desktop" = {
        fingerprint = {
          HDMI-0 = "00ffffffffffff000472700b234f10331f21010380351e78ea3135a5554ea1260c5054bfef80714f8140818081c081009500b3000101023a801871382d40582c4500142c2100001e000000fd0030641e7819000a202020202020000000fc004b413234325920450a20202020000000ff0044333331303446323333573031018d020323f2470103049012139f230907058301000065030c001000681a000001013064e62a4480a07038274030203500142c2100001a605980a07038144030203500142c2100001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000093";
          DP-0 = "00ffffffffffff004c2d450d48425030151c0104a53c22783b5295a556549d250e5054bb8c00b30081c0810081809500a9c001010101215280a07238304088c8350056502100001c000000fd003a48525216010a202020202020000000fc00433237463339380a2020202020000000ff004854514b3530363238360a202001ca02030ff14290042309070783010000023a801871382d40582c450056502100001e011d007251d01e206e28550056502100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010";
        };
	config = {
	  # Acer vertical
          HDMI-0 = {
            enable = true;
	    mode = "1920x1080";
	    position = "0x0";
	    rotate = "left";
	  };
          
	  # Samsung horizontal
	  DP-0 = {
            enable = true;
	    mode = "1920x1080";
	    position = "1920x0";
	    primary = true;
	  };
	};
      };
    "laptop" = {
      fingerprint = {
        DP-2 = "00ffffffffffff0006100fa00000000010150104a5211578026fb1a7554c9e250c505400000001010101010101010101010101010101ef8340a0b0083470302036004bcf1000001a000000fc00436f6c6f72204c43440a20202000000010000000000000000000000000000000000010000000000000000000000000000000e7";
	  };
	  config = {
        DP-2 = {
          enable = true;
		  mode = "2880x1800";
		  position = "0x0";
		  primary = true;
		  scale = { x = 1; y = 1; };
		};
	  };
    };
    };
  };
}

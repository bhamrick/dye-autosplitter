state("dyegame")
{
	int purplePigments	: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x16C;
	int bluePigments	: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x170;
	int greenPigments	: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x174;
	int redPigments		: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x178;
	float purpleBoss	: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x17C;
	float blueBoss		: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x180;
	float greenBoss		: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x184;
	float redBoss		: "mono.dll", 0x262110, 0x20, 0x40, 0x3b8, 0x38, 0x188;
	float bossTimer		: "mono.dll", 0x2676F8, 0x160, 0x368, 0x13C;
}

init
{
	vars.world = 0;
	vars.pigmentCheckpoint = 0;
	vars.stability = 0;
}

split
{
	if(timer.CurrentSplit == null)
	{
		return false;
	}
	if(current.purplePigments == old.purplePigments
		&& current.bluePigments == old.bluePigments
		&& current.greenPigments == old.greenPigments
		&& current.redPigments == old.redPigments
		&& current.purpleBoss == old.purpleBoss
		&& current.blueBoss == old.blueBoss
		&& current.greenBoss == old.greenBoss
		&& current.redBoss == old.redBoss
	) {
		vars.stability += 1;
	} else {
		vars.stability = 0;
	}
	// In the case of a normal split, determine how many pigments we're obtaining
	// Default to 5 (all pigments from a level)
	int desiredPigments = 5;
	System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"\((\d+)\)");
	System.Text.RegularExpressions.Match match = r.Match(timer.CurrentSplit.Name);
	if(match.Success)
	{
		desiredPigments = int.Parse(match.Groups[1].Captures[0].Value);
	}
	
	if(vars.world == 0)
	{
		if(timer.CurrentSplit.Name == "Vultures"
			|| timer.CurrentSplit.Name == "Purple"
			|| timer.CurrentSplit.Name == "Purple Boss"
		) {
			// Boss split
			if(current.purpleBoss > 0.0 || current.bossTimer > 0.0)
			{
				vars.world = 1;
				vars.pigmentCheckpoint = 0;
				return true;
			}
		} else {
			if(vars.stability >= 5 && current.purplePigments >= vars.pigmentCheckpoint + desiredPigments) {
				vars.pigmentCheckpoint += desiredPigments;
				return true;
			}
		}
	} else if(vars.world == 1) {
		if(timer.CurrentSplit.Name == "Ice Golem"
			|| timer.CurrentSplit.Name == "Blue"
			|| timer.CurrentSplit.Name == "Blue Boss"
		) {
			// Boss split
			if(current.blueBoss > 0.0 || current.bossTimer > 0.0)
			{
				vars.world = 2;
				vars.pigmentCheckpoint = 0;
				return true;
			}
		} else {
			if(vars.stability >= 5 && current.bluePigments >= vars.pigmentCheckpoint + desiredPigments) {
				vars.pigmentCheckpoint += desiredPigments;
				return true;
			}
		}
	} else if(vars.world == 2) {
		if(timer.CurrentSplit.Name == "Slime King"
			|| timer.CurrentSplit.Name == "Green"
			|| timer.CurrentSplit.Name == "Green Boss"
		) {
			// Boss split
			if(current.greenBoss > 0.0 || current.bossTimer > 0.0)
			{
				vars.world = 3;
				vars.pigmentCheckpoint = 0;
				return true;
			}
		} else {
			if(vars.stability >= 5 && current.greenPigments >= vars.pigmentCheckpoint + desiredPigments) {
				vars.pigmentCheckpoint += desiredPigments;
				return true;
			}
		}
	} else if(vars.world == 3) {
		if(timer.CurrentSplit.Name == "Inferno"
			|| timer.CurrentSplit.Name == "Red"
			|| timer.CurrentSplit.Name == "Red Boss"
		) {
			// Boss split
			if(current.redBoss > 0.0 || current.bossTimer > 0.0)
			{
				vars.world = 4;
				vars.pigmentCheckpoint = 0;
				return true;
			}
		} else {
			if(vars.stability >= 5 && current.redPigments >= vars.pigmentCheckpoint + desiredPigments) {
				vars.pigmentCheckpoint += desiredPigments;
				return true;
			}
		}
	}
}

update
{
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.world = 0;
		vars.pigmentCheckpoint = 0;
	}
}

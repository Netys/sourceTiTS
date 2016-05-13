package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.Util.*;
	
	public class CoCDoppleganger extends PlayerCharacter
	{
		private var _roundCount:int = 0;
		public function CoCDoppleganger() 
		{
			this._isLoading = false;
			this.loadSaveObject(kGAMECLASS.pc.getSaveObject());
			this.personality = kGAMECLASS.pc.cor();
			this.a = "";
			this.capitalA = "";
			this.inventory = [];
			this.credits = 0;
			this.XPRaw = bossXP();
		}
		
		override public function get long():String
		{
			var str:String = "";
			
			str += "You are fighting the doppelganger. " + mf("He", "She") +" is a ";
			str += String(Math.floor(tallness / 12) + " foot " + tallness % 12 + " inch tall ");
			str += race() + ", with " + bodyType() + ". ";
			
			str += mf("His", "Her") + " visage is " + faceDesc() + ".";
			
			if(hasHair()) str += " "  + mf("His", "Her") + " " + hairDescript() + " is parted by " + earsDescript(true, true);
			else str += " "  + mf("His", "Her") + " head is toped by " + earsDescript(true, true);
			
			str += ". " +mf("He", "She") + " keeps exploring the area around " + mf("his", "her") +" mouth with " + mf("his", "her") +" tongue with a horribly acquisitive, sensual interest.";
			str += " " + mf("He", "She") + " moves around on " + mf("his", "her") +" " + legs() + " with a twitchy jerkiness, " + mf("his", "her") + " " + hipDescript() + " swinging and tightening.";
			if (hasTail()) str += " " + mf("His", "Her") + " [pc.tails] flicks this way and that.";
			str += " " + mf("He", "She") + " wields the exact same " + getWeaponName() + " you do, and is dressed in the mirror image of your [pc.gear]. ";
			if (biggestTitSize() >= 2) str += "It’s difficult not to notice the way the mirror image of your " + breastDescript(biggestTitRow()) + " ebbs and heaves within it.";
			
			return str;
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			addButton(0, "Strike", mirrorAttack, true);
			addButton(1, "Shoot", mirrorAttack, false);
			addButton(8, "Wait", handlePlayerWait);
		}
		
		public function mirrorAttack(melee:Boolean):void
		{
			clearOutput();
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (!melee) {
				output("As you direct " + rangedWeapon.attackNoun + " from your [pc.rangedWeapon] at the doppleganger, " + pc.mf("he", "she") + " smiles mockingly, and mirrors your move exactly with " + pc.mf("his", "her") + " duplicate [pc.rangedWeapon].");
				var damage:TypeCollection = pc.rangedDamage();
				damageRand(damage, 15);
				applyDamage(damage, pc, this);
				applyDamage(damage, this, pc);
				
				if (pc.lustQ() == 100 && this.lustQ() == 100 || pc.HP() < 1 && this.HP() < 1) {
					if (rand(2) == 0) {
						pc.HP(1);
						pc.lust( -1);
					} else {
						HP(1);
						lust( -1);
					}
				}
			}
			else if (rand(8) < 6)
			{
				output("As you swing your [pc.meleeWeapon] at the doppleganger, " + pc.mf("he", "she") + " smiles mockingly, and mirrors your move exactly, lunging forward with " + pc.mf("his", "her") + " duplicate [pc.meleeWeapon].");
				output("  At the very last moment, you twist downwards and strike into your opponent’s trunk, drawing a gasp of pain from " + pc.mf("him", "her") +" as " + pc.mf("he", "she") +" clumsily lashes " + pc.mf("his", "her") + " own [pc.meleeWeapon] over you. It’s your turn to mirror " + pc.mf("him", "her") +", smiling mockingly at " + pc.mf("his", "her") +" rabid snarls as " + pc.mf("he", "she") +" resets " + pc.mf("him", "her") +"self, " + pc.mf("his", "her") +" voice bubbling and flickering for a moment as " + pc.mf("he", "she") +" tries to maintain control.");
				var d:TypeCollection = pc.meleeDamage();
				d.multiply(2);
				damageRand(d, 15);
				applyDamage(d, pc, this, "melee");
			}
			else
			{
				output("As you swing your [pc.meleeWeapon] at the doppleganger, " + pc.mf("he", "she") + " smiles mockingly, and mirrors your move exactly, lunging forward with " + pc.mf("his", "her") + " duplicate [pc.meleeWeapon].");
				output("  Your " + possessive(meleeWeapon.longName) + " meet with a bone-jarring impact, and you are sent staggering backwards by a force exactly equal to your own.");
				output("\n\n“<i>Try again, [pc.name],</i>” the doppelganger sneers, derisively miming your falter. “<i>C’mon. Really test yourself.</i>”");
			}
			CombatManager.processCombat();
		}
		
		public function teaseReactionsFail():void
		{
			teaseReactions(0);
		}
		
		public function teaseReactions(damage:Number):String
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			output("You move your hands seductively over your body, and - you stop. The doppelganger stops too, staring at you with wicked coyness, " + pc.mf("his", "her") +" hands frozen on " + pc.mf("his", "her") +" form exactly where yours are. Glaring back, you begin your slow, lustful motions again, as your reflection does the exact same thing. It’s a lust off!");
			
			if (damage > 0 && rand(pc.WQ() / 10) < 6)
			{
				output("\n\nYou determinedly display and twist your carnality to what you know are its best advantages, ignoring what the doppelganger is doing- you’re extremely familiar with it, after all. After a few slow seconds crawl past a blush settles upon your reflection’s face, and "+ pc.mf("he", "she") +" hands falter and stop being able to follow yours as "+ pc.mf("he", "she") +" stares at what you’re doing.");
				
				output("\n\n“<i>It’s- it’s been so long,</i>” " + pc.mf("he", "she") +" groans, managing to break away to stare into your smirking, smouldering eyes with lust-filled rage. “<i>But I’ll have that, I’ll have everything soon enough!</i>”");
				
				applyDamage(new TypeCollection( { tease : damage } ), pc, this);
			}
			else
			{
				output("You keep moving and displaying your body as best you can, but an overwhelming amount of self-awareness creeps in as your doppelganger mockingly copies you. Is that really what you look like when you do this? It looks so cheap, so clumsy, so desperate. As a blush climbs onto your face you feel a vague sense of vertigo as control of the situation shifts- you copy the doppelganger as "+ pc.mf("he", "she") +" cruelly continues to slide "+ pc.mf("his", "her") +" hands over "+ pc.mf("his", "her") +" body exaggeratedly.");
				
				output("\n\n“<i>What’s the matter, [pc.name]?</i>” " + pc.mf("he", "she") +" breathes, staring lustfully into your eyes as " + pc.mf("he", "she") +" sinks both hands into " + pc.mf("his", "her") +" crotch and bends forward, forcing you close to " + pc.mf("his", "her") +" [pc.face]. “<i>Never tried it in front of a mirror? You were missing out on the nasty little tramp you are.</i>”");
				
				applyDamage(new TypeCollection( { tease : damage + rand (5) } ), this, pc);
			}
			return "ABORT";
		}
		
		private function addTalkShit():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			switch (_roundCount)
			{
				case 0:
					output("\n\n“<i>You feel it, don’t you?</i>” The doppelganger whispers, crooking your mouth into a vicious grin. “<i>The transfer. The mirror is a vacuum without a being inside it; it reaches out for someone to complete it. Your being, to be exact. Mine wants to be free a lot more than yours. Ten years more, to be exact.</i>”");
					output("\n\n[pc.HeShe] goes on in a dull croon as [pc.heShe] continues to circle you, moving with the odd, syncopated jerks of a creature in a body that has only existed for a couple of minutes. “<i>Just let it happen, [pc.name]. You can’t beat me. I am you, only with the knowledge and powers of a demon. Accept your fate.</i>”");
					output("\n\nA weird fluttering feeling runs up your arm, and with a cold chill you look down to see it shimmer slightly, as if you were looking at it through running water.");
					output("\n\n<b>You need to finish this as fast as you can.</b>");
					break
					
				case 1:
					output("\n\n“<i>Do you know, I can’t even remember what gender I was before I got stuck in that mirror?</i>” the doppelganger says, as [pc.heShe] slides a hand between your thighs’ mirror counterparts thoughtfully. “<i>I loved changing all the time. Being stuck as one gender seemed so boring when the tools to shift from one shape to the next were always there. That’s why this was my punishment. Forced to change all the time, at the unthinking behest of whoever happened to look into this cursed thing. You have to give Lethice credit, she’s not just cruel, she’s got imagination too. It’s a hell of a combination. I’d hate to see what she had in store for you.</i>”");
					break;
					
				case 2:
					output("\n\n“<i>This, though... this I like, [pc.name].</i>” [pc.HeShe] closes [pc.hisHer] eyes and");
					if (pc.hasCock()) output(" strokes [pc.hisHer] [pc.cock]");
					else if (pc.hasVagina()) output(" slides two fingers into [pc.hisHer] [pc.vagina] and gently frigs [himself]");
					else output(" slips a hand ");
					output(" underneath [pc.hisHer] " + gearDescript() +". The sheer bizarreness of seeing yourself masturbate gives you pause; again the unreality intensifies, and you feel yourself shimmer uncertainly. “<i>Once I’m out of here, I’m going to hang onto this. Revel in not changing my form for once, as a tribute to the kind soul who gave me it!</i>”");
					output("\n\nIt’s getting harder to ignore the way your body shimmers and bleeds contrast at the edges, whilst your reflection only becomes more and more sharply defined.");
					output("\n\n<b>This is something, you realize with a growing horror, which is really going to happen if you don’t stop it.</b>");
					break;
					
				case 3:
					output("\n\n“<i>Your memories flow to me [pc.name], as you fade like a memory. I can taste them...</i>” You struggle to stay focused, try and force your body and mind not to blur like a fingerprint on a windowpane as the doppelganger sighs beatifically.");
					output("\n\n“<i>Not bad, not bad. You led quite an interesting life for an Ingnam peasant, didn’t you? Got around. Not enough sex, though. Nowhere near enough sex. Don’t worry- I’ll correct that mistake, in due course.</i>”");
					break;
					
				case 4:
					output("\n\n“<i>Did you really think you could defeat Lethice, peasant?</i>” the doppelganger roars. [pc.HeShe] moves and speaks with confidence now, [pc.hisHer] old twitchiness gone, revelling and growing into [pc.hisHer] new form.");
					output("\n\nYou don’t dare open your mouth to hear what pale imitation of that voice comes out. “<i>Oh, by grit, crook and luck you’ve gotten this far, but defeat the demon queen? You, who still cling onto your craven, simple soul and thus know nothing of demonhood, of its powers, of its sacrifices? I am doing you and the world a favor here, [pc.name]-that-was, because I am not just taking this fine body but also the mantel it so clumsily carried. With my knowledge and your brute physicality, I will have my revenge on Lethice, and the world will be free of her and her cruelty!</i>” [pc.HeShe] screams with laughter. The ringing insanity of it sounds increasingly muffled to you, as if it were coming through a pane of glass.");
					output("\n\n<b>You have time and strength for one last gambit...</b>");
					break;
				
				case 5:
					output("\n\nThe shimmering intensifies for a moment as something... shifts....");
					
					pc.lust(pc.lustMax(), true);
					
					break;
					
				default:
					output("\n\n“<i>How did you even survive?</i>” the doppelganger looks in confusion. “<i>Regardless, I'm still taking your body.</i>”");
					_roundCount = 4;
					break;
			}
			
			_roundCount++;
		}
		
		public function handlePlayerWait():void
		{
			output("Your doppleganger similarly opts to take a momentary break from the ebb and flow of combat.");
			CombatManager.processCombat();
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			if (hasStatusEffect("Stunned")) {
				output("Your duplicate is too stunned, buying you another round!");
				return;
			}
			output("Your duplicate chuckles in the face of your attacks.");
			addTalkShit();
		}
	}
}
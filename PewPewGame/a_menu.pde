void intro() {
  
  background(black);
  
  fill(0);
  stroke(255);
  rect(width/2, height/2, 300, 60);
  
  rect(width/2, height/1.5, 300, 60);
  
  rect(width/2, height/1.2, 300, 60);
  
  textSize(100);
  fill(pink);
  text("PEW PEW", width/2, height/4);
  
  textSize(50);
  text("Start Game", width/2, height/2);
  
  text("Options", width/2, height/1.5);
  
  text("Quit Game", width/2, height/1.2);
  
}

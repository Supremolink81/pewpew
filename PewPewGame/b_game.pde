void game() {
  background(green);
  noStroke();
  
  int i = 0;
  while (i <objects.size()) {
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if (obj.isDead()) {
      objects.remove(i);
    } else {
      i++;
    }
  }
  
  if (frameCount % 60 == 0) {
    objects.add(new Enemy());
  }
  
  fill(0);
  stroke(255);
  rect(width/7, height/1.1, 150, 60);
  
  fill(pink);
  textSize(50);
  text("Back", width/7, height/1.1);
}

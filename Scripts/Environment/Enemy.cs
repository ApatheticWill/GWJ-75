using Godot;
using System;

public partial class Enemy : Area2D
{
	[Export] public bool move;
	[Export] public int xStart;
	[Export] public int xFinal;
	[Export] public int yStart;
	[Export] public int yFinal;
	[Export] public float seconds;
	public bool finished = false;
	private Tween tween;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		if(move)
		{
			Position = new Vector2(xStart,yStart);
			
			startTween();
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}
	public void startTween()
	{
		GD.Print("se llama startTween");
		if(tween != null)
		{
			tween.Kill();
		}
		tween =  CreateTween();
		
		if(!finished)
		{
			tween.TweenProperty(this, "position", new Vector2(xFinal,yFinal), seconds);
		}
		else{
			tween.TweenProperty(this, "position", new Vector2(xStart,yStart), seconds);

		}
		finished = !finished;
		tween.Play();
		tween.Finished +=startTween ;
	}
}

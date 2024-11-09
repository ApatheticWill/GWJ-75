using Godot;
using System;

public partial class playerReflect : Area2D
{
	[Export]
	public Node2D player;
    public override void _Ready()
    {
        AreaEntered += chocaArea3D;
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
		Position = new Vector2(player.Position.X,-player.Position.Y);
	}
	public void chocaArea3D( Area2D area)
	{
		if(area.IsInGroup("enemies"))
		{
			area.QueueFree();
		}
		if(area.IsInGroup("points"))
		{
			area.QueueFree();
		}
	}
}

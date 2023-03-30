Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public static class Mouse
{
    [DllImport("user32.dll", SetLastError = true)]
    private static extern uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

    [StructLayout(LayoutKind.Sequential)]
    public struct INPUT
    {
        public int type;
        public MOUSEINPUT mi;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct MOUSEINPUT
    {
        public int dx;
        public int dy;
        public uint mouseData;
        public uint dwFlags;
        public uint time;
        public IntPtr dwExtraInfo;
    }

    private const int INPUT_MOUSE = 0;
    private const int MOUSEEVENTF_MOVE = 0x0001;

    public static void Move(int dx, int dy)
    {
        INPUT input = new INPUT();
        input.type = INPUT_MOUSE;
        input.mi.dx = dx;
        input.mi.dy = dy;
        input.mi.dwFlags = MOUSEEVENTF_MOVE;

        SendInput(1, new INPUT[] { input }, Marshal.SizeOf(input));
    }
}
"@

while ($true) {
    [Mouse]::Move(0, 1) # move .1cm up
    Start-Sleep -Milliseconds 30000
    [Mouse]::Move(0, -1) # move .1cm down
    Start-Sleep -Milliseconds 30000
}
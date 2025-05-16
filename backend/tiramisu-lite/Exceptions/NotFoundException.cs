namespace tiramisu_lite.Exceptions;

public class NotFoundException(string message)
    : Exception(message)
{
    public static void ThrowIfNull(object? argument, string message)
    {
        if (argument is null)
        {
            throw new NotFoundException(message);
        }
    }
}
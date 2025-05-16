namespace tiramisu_lite.Exceptions;

public class InvalidDateException(string message, string? paramName)
    : ArgumentException(message, paramName)
{
    public static void ThrowIfPast(DateTime date, string? paramName)
    {
        if (date < DateTime.Now)
        {
            throw new InvalidDateException("Date cannot be in the past.", paramName);
        }
    }
}
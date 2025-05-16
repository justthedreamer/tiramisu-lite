using System.Diagnostics;
using System.Text;

/// <summary>
/// Request and response logging middleware.
/// </summary>
public class LoggingMiddleware(RequestDelegate next, ILogger<LoggingMiddleware> logger)
{
    public async Task InvokeAsync(HttpContext context)
    {
        logger.LogDebug("LoggingMiddleware invoked.");

        var stopwatch = new Stopwatch();
        stopwatch.Start();

        try
        {
            await LogRequestAsync(context);
        }
        catch (Exception e)
        {
            logger.LogWarning(e, "Cannot log request. Error message: {Message}", e.Message);
        }

        await next(context);

        try
        {
            LogResponse(context, stopwatch);
        }
        catch (Exception e)
        {
            logger.LogWarning(e, "Cannot log response. Error message: {Message}", e.Message);
        }
        finally
        {
            stopwatch.Stop();
        }
    }

    private async Task LogRequestAsync(HttpContext context)
    {
        context.Request.EnableBuffering(); // <== Umożliwia wielokrotny odczyt

        string body = string.Empty;
        if (context.Request.ContentLength > 0 && 
            context.Request.Body.CanRead)
        {
            using var reader = new StreamReader(
                context.Request.Body,
                encoding: Encoding.UTF8,
                detectEncodingFromByteOrderMarks: false,
                bufferSize: 1024,
                leaveOpen: true);

            body = await reader.ReadToEndAsync();
            context.Request.Body.Position = 0; // <== Resetuj pozycję
        }

        logger.LogInformation(
            "Incoming request: {Method} {Url} from {IPAddress}. Body: {Body}",
            context.Request.Method,
            context.Request.Path,
            context.Connection.RemoteIpAddress,
            body);
    }

    private void LogResponse(HttpContext context, Stopwatch stopwatch)
    {
        logger.LogInformation(
            "Outgoing response for: {Method} {Path} from {IPAddress} handled in {ElapsedMilliseconds} ms.",
            context.Request.Method,
            context.Request.Path,
            context.Connection.RemoteIpAddress,
            stopwatch.ElapsedMilliseconds);
    }
}

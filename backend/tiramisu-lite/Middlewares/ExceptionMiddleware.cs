namespace tiramisu_lite.Middlewares;

using System.Net;
using System.Net.Mime;
using tiramisu_lite.Exceptions;

public class ExceptionMiddleware(RequestDelegate next)
{
    public async Task InvokeAsync(HttpContext httpContext, ILogger<ExceptionMiddleware> logger)
    {
        try
        {
            await next(httpContext);
        }
        catch (ArgumentException e)
        {
            httpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            httpContext.Response.ContentType = MediaTypeNames.Text.Plain;
            httpContext.Response.WriteAsync(e.Message);
            logger.LogInformation(e.ToString());
        }
        catch (NotFoundException e)
        {
            httpContext.Response.StatusCode = (int)HttpStatusCode.NotFound;
            httpContext.Response.ContentType = MediaTypeNames.Text.Plain;
            httpContext.Response.WriteAsync(e.Message);
            logger.LogInformation(e.ToString());
        }
        catch (AlreadyExistException e)
        {
            httpContext.Response.StatusCode = (int)HttpStatusCode.Conflict;
            httpContext.Response.ContentType = MediaTypeNames.Text.Plain;
            httpContext.Response.WriteAsync(e.Message);
            logger.LogInformation(e.ToString());
        }
        catch (Exception e)
        {
            httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            httpContext.Response.ContentType = MediaTypeNames.Text.Plain;
            httpContext.Response.WriteAsync($"Internal Server Error {e.Message}");
            logger.LogInformation(e.ToString());
        }
    }
}
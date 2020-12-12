<?php
namespace App\Middlewares;

use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Psr\Http\Message\ResponseInterface as Response;
// use Psr\Container\ContainerInterface;
use Slim\Csrf\Guard as Guard;

class CsrfMiddleware extends Guard implements Middleware
{
    public function process(Request $request, RequestHandler $handler): Response
    {
        // $this->setStorage();
        if (in_array($request->getMethod(), ['POST', 'PUT', 'DELETE', 'PATCH'])) {
            $body = $request->getParsedBody();
            $body = $body ? (array) $body : [];
            $name = isset($body[$this->prefix . '_name']) ? $body[$this->prefix . '_name'] : false;
            $value = isset($body[$this->prefix . '_value']) ? $body[$this->prefix . '_value'] : false;
            if (!$name || !$value || !$this->validateToken($name, $value)) {
                // Need to regenerate a new token, as the validateToken removed the current one.
                $request = $this->generateToken();

                $failureCallable = $this->handleFailure();
                return $failureCallable($request, $handler);
            }
            // Generate new CSRF token if persistentTokenMode is false, or if a valid keyPair has not yet been stored
            if (!$this->persistentTokenMode || !$this->loadLastKeyPair()) {
                $request = $this->generateToken();
            } elseif ($this->persistentTokenMode) {
                $pair = $this->loadLastKeyPair() ? $this->keyPair : $this->generateToken();
                // $request = $this->attachRequestAttributes($request, $pair);
                $request = $this->appendTokenToRequest($request, $pair);
            }
            // Enforce the storage limit
            $this->enforceStorageLimit();
            return $handler->handle($request);
        }
        return $handler->handle($request);
    }
}

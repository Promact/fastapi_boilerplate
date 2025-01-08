"""
Main FastAPI application file.
Define your FastAPI app and include routers here.
"""

from fastapi import FastAPI

app = FastAPI()

# Include your routers here
# from app.routes import users, items
# app.include_router(users.router)
# app.include_router(items.router)


@app.get("/")
async def root():
    return {"message": "Hello World"}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)

import Docker, { Container } from "dockerode";
const docker = new Docker();
export async function createContainer(
  language: string,
  code: string,
  input: string
) {
  switch (language) {
    case "javascript":
      return await docker.createContainer({
        Image: "node:14",
        Cmd: [
          "bash",
          "-c",
          `echo '${code}' > script.js && echo '${input}' | node script.js`,
        ],
        Tty: false,
        OpenStdin: true,
      });
    case "python":
      // Similar for Python
      return await docker.createContainer({
        Image: "python:latest",
        Cmd: [
          "bash",
          "-c",
          `echo '${code}' > script.py && echo '${input}' | python script.py`,
        ],
        Tty: false,
        OpenStdin: true,
      });
    case "cpp":
      // Similar for C++
      // console.log(code);
      return await docker.createContainer({
        Image: "gcc:latest",
        Cmd: [
          "bash",
          "-c",
          `echo '${code}' > script.cpp && g++ script.cpp -o script && echo '${input}' | timeout 1s ./script`,
        ],
        Tty: false,
        OpenStdin: true,
      });
    // Add cases for other languages
    case "dart":
      return await docker.createContainer({
        Image: "dart:latest",
        Cmd: [
          "bash",
          "-c",
          `echo '${code}'> script.dart &&  echo '${input}'| dart script.dart`,
        ],
        Tty: false,
        OpenStdin: true,
      });

    default:
      throw new Error("Language not supported");
  }
}

export async function startContainer(container: Container) {
  // console.log(input);
  return new Promise((resolve, reject) => {
    container.start((err, data) => {
      if (err) {
        reject(err);
      } else {
        container.wait((err, data) => {
          if (err) {
            reject(err);
          } else {
            if (data.StatusCode == 124) {
              resolve("Time Limit Exceeded");
            } else {
              console.log(data);
              containerLogs(container).then((logs) => {
                resolve(logs);
                // console.log(logs);
              });
            }
          }
        });
      }
      // console.log(data);
    });
  });
}

export async function containerLogs(container: Container) {
  return new Promise((resolve) => {
    container.logs(
      { follow: false, stdout: true, stderr: true },
      (err, stream) => {
        // console.log(stream);
        // let output = "";

        if (err) {
          resolve(`Execution error: ${err.message}`);
        }

        const output = stream?.toString("utf8").replace(/[^ -~]/g, "");

        resolve(output);
      }
    );
  });
}

export async function removeContainer(container: Container) {
  return new Promise<void>((resolve) => {
    container.remove({ force: true }, () => {
      resolve();
    });
  });
}

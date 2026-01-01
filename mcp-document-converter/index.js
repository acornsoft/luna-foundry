const { Server } = require('@modelcontextprotocol/sdk/server/index.js');
const { StdioServerTransport } = require('@modelcontextprotocol/sdk/server/stdio.js');
const { CallToolRequestSchema } = require('@modelcontextprotocol/sdk/types.js');

const server = new Server(
  {
    name: 'document-converter',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === 'convert_document') {
    const { inputFile, outputFormat, templatePath, outputDir } = request.params.arguments;
    // Call PowerShell script
    const { spawn } = require('child_process');
    const psPath = 'path/to/Convert-Document.ps1'; // Update with actual path
    const ps = spawn('powershell.exe', ['-File', psPath, inputFile, outputFormat, templatePath || '', outputDir || '']);
    
    let output = '';
    ps.stdout.on('data', (data) => { output += data.toString(); });
    ps.stderr.on('data', (data) => { output += data.toString(); });
    
    return new Promise((resolve) => {
      ps.on('close', (code) => {
        resolve({
          content: [{ type: 'text', text: Conversion :  }],
        });
      });
    });
  }
  return { content: [] };
});

server.setRequestHandler('tools/list', async () => {
  return {
    tools: [
      {
        name: 'convert_document',
        description: 'Convert a Markdown document to DOCX or PDF using pandoc and custom templates.',
        inputSchema: {
          type: 'object',
          properties: {
            inputFile: { type: 'string', description: 'Path to the input Markdown file.' },
            outputFormat: { type: 'string', enum: ['docx', 'pdf'], description: 'Output format.' },
            templatePath: { type: 'string', description: 'Path to the custom Office template (optional).' },
            outputDir: { type: 'string', description: 'Output directory (optional).' },
          },
          required: ['inputFile', 'outputFormat'],
        },
      },
    ],
  };
});

const transport = new StdioServerTransport();
server.connect(transport).then(() => {
  console.error('Document Converter MCP Server running');
}).catch(console.error);
using System.Text.Json;

namespace Acornsoft.Luna.MacroFlow.Foundry;

/// <summary>
/// Loads MacroFlow prompt templates from JSON files.
/// </summary>
public sealed class PromptLoader
{
    private readonly string _promptsPath;

    public PromptLoader()
    {
        // Assume prompts are copied to foundry/macroflow/ in the output directory
        _promptsPath = Path.Combine(AppContext.BaseDirectory, "foundry", "macroflow");
    }

    public PromptTemplate? LoadPrompt(string phase)
    {
        ArgumentException.ThrowIfNullOrEmpty(phase);

        string filePath = Path.Combine(_promptsPath, $"{phase.ToLowerInvariant()}.prompt.json");
        if (!File.Exists(filePath))
        {
            return null;
        }

        string json = File.ReadAllText(filePath);
        return JsonSerializer.Deserialize<PromptTemplate>(json);
    }
}

public sealed class PromptTemplate
{
    public string? Phase { get; set; }
    public string? System { get; set; }
    public string? UserTemplate { get; set; }
}